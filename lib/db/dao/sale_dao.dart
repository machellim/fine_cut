import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/sales_table.dart';
import 'package:fine_cut/models/product_profit.dart';

part 'sale_dao.g.dart';

@DriftAccessor(tables: [Sales])
class SaleDao extends DatabaseAccessor<AppDatabase> with _$SaleDaoMixin {
  final AppDatabase db;

  SaleDao(this.db) : super(db);

  Future<List<Sale>> getAllSales() {
    return (select(sales)
          ..where((t) => t.status.equals('active'))
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Sale>> getSalesByCashRegisterId(int cashRegisterId) {
    return (select(sales)
          ..where(
            (t) =>
                t.status.equals('active') &
                t.cashRegisterId.equals(cashRegisterId),
          )
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> createOrUpdateSale(
    SalesCompanion saleCompanion,
    RecordAction recordAction,
    Product selectedProduct,
  ) {
    return transaction(() async {
      saleCompanion = saleCompanion.copyWith(
        aliasProductName: Value(selectedProduct.name),
      );

      if (recordAction == RecordAction.create) {
        // Update the product stock after creating the sale
        if (selectedProduct.trackStock) {
          await db.productDao.updateStockProduct(
            productId: selectedProduct.id,
            quantityChange: saleCompanion.quantity.value * -1, // venta → resta
          );
        }
        return into(sales).insert(saleCompanion);
      } else {
        final id = saleCompanion.id.value;

        // Get the previous sale to calculate the stock difference
        final previousSale = await (select(
          sales,
        )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

        final rowsUpdated = await (update(
          sales,
        )..where((tbl) => tbl.id.equals(id))).write(saleCompanion);

        if (rowsUpdated > 0 && previousSale != null) {
          // Update the product stock based on the difference
          if (selectedProduct.trackStock) {
            // Calculate the difference in quantity between new and previous sale
            final quantityDiff =
                saleCompanion.quantity.value - previousSale.quantity;

            await db.productDao.updateStockProduct(
              productId: selectedProduct.id,
              quantityChange: quantityDiff * -1,
            );
          }
        }

        return rowsUpdated > 0
            ? id
            : -1; // retorna id actualizado o -1 si no existe
      }
    });
  }

  Future<int> softDeleteSale(int id) {
    return transaction(() async {
      // 1. Search the sale to be logically deleted
      final sale = await (select(
        sales,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      if (sale == null) return -1; // sale does not exist

      // 2. Search the product associated
      final product = await (select(
        db.products,
      )..where((p) => p.id.equals(sale.productId))).getSingleOrNull();

      if (product == null) return -1; // product does not exist

      // 3. Update the sale as deleted
      final rowsUpdated = await (update(sales)..where((t) => t.id.equals(id)))
          .write(SalesCompanion(status: Value(RecordStatus.deleted)));

      // 4. If updated and the product tracks stock → return quantity to inventory
      if (rowsUpdated > 0 && product.trackStock) {
        await db.productDao.updateStockProduct(
          productId: product.id,
          quantityChange: sale.quantity, // return to inventory
        );
      }

      return rowsUpdated > 0 ? id : -1;
    });
  }

  Future<List<Purchase>> getPurchasesBySubproductId(int subproductId) async {
    final query =
        select(db.purchases).join([
            innerJoin(
              db.productSubproducts,
              db.productSubproducts.productId.equalsExp(db.purchases.productId),
            ),
          ])
          ..where(db.productSubproducts.subproductId.equals(subproductId))
          ..where(db.purchases.isSoldOut.equals(false))
          ..limit(AppConstants.listResultsLimit);
    final results = await query.map((row) => row.readTable(db.purchases)).get();
    return results;
  }

  Future<List<Purchase>> getPurchasesSubproduct(
    int subproductId, {
    String? filter,
  }) async {
    final query = select(db.purchases).join([
      innerJoin(
        db.productSubproducts,
        db.productSubproducts.productId.equalsExp(db.purchases.productId),
      ),
    ]);

    query.where(db.productSubproducts.subproductId.equals(subproductId));
    query.where(db.purchases.isSoldOut.equals(false));

    if (filter != null && filter.isNotEmpty) {
      query.where(db.purchases.aliasProductName.like('%$filter%'));
    }

    // Order by createdAt DESC
    query.orderBy([
      OrderingTerm(expression: db.purchases.createdAt, mode: OrderingMode.desc),
    ]);

    final results = await query.map((row) => row.readTable(db.purchases)).get();

    return results;
  }

  Future<List<Sale>> getSalesByPurchaseId(int purchaseId) {
    return (select(sales)
          ..where((s) => s.purchaseId.equals(purchaseId))
          ..orderBy([(s) => OrderingTerm.desc(s.saleDate)]))
        .get();
  }

  Future<bool> existsAsSubproduct(int productId) async {
    final query = select(db.productSubproducts)
      ..where((tbl) => tbl.subproductId.equals(productId));

    final result = await query.getSingleOrNull();
    return result != null;
  }

  /*Future<double> getProfitByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    // 1. Calculate purchases
    final purchasesResult = await customSelect(
      '''
    SELECT 
      SUM(quantity) AS total_quantity, 
      SUM(total_cost) AS total_cost
    FROM purchases
    WHERE purchase_date BETWEEN ? AND ?
    ''',
      variables: [
        Variable.withDateTime(startDate),
        Variable.withDateTime(endDate),
      ],
      readsFrom: {db.purchases},
    ).getSingle();

    final totalQuantityPurchased =
        (purchasesResult.data['total_quantity'] as num?)?.toDouble() ?? 0.0;
    final totalCostPurchased =
        (purchasesResult.data['total_cost'] as num?)?.toDouble() ?? 0.0;

    final avgCostPerUnit = totalQuantityPurchased > 0
        ? totalCostPurchased / totalQuantityPurchased
        : 0.0;

    // 2. Calculate sales
    final salesResult = await customSelect(
      '''
    SELECT 
      SUM(quantity) AS total_quantity, 
      SUM(total_price) AS total_price
    FROM sales
    WHERE sale_date BETWEEN ? AND ? 
      AND status = 'active'
    ''',
      variables: [
        Variable.withDateTime(startDate),
        Variable.withDateTime(endDate),
      ],
      readsFrom: {sales},
    ).getSingle();

    final totalQuantitySold =
        (salesResult.data['total_quantity'] as num?)?.toDouble() ?? 0.0;
    final totalSales =
        (salesResult.data['total_price'] as num?)?.toDouble() ?? 0.0;

    // 3. Calculate cost of goods sold
    final costOfGoodsSold = totalQuantitySold * avgCostPerUnit;

    // 4. Calculate profit
    final profit = totalSales - costOfGoodsSold;

    return profit;
  }*/

  Future<List<ProductProfit>> getProfitByProduct(
    String startDate,
    String endDate,
  ) async {
    // Consulta combinada por producto
    final result = await customSelect(
      '''
      SELECT 
          s.product_id,
          s.alias_product_name AS product,
          COALESCE(SUM(s.quantity), 0) AS total_quantity_sold,
          COALESCE(SUM(s.total_price), 0) AS total_sales,
          COALESCE(p.total_quantity_purchased, 0) AS total_quantity_purchased,
          COALESCE(p.total_cost_purchased, 0) AS total_cost_purchased
      FROM sales s
      LEFT JOIN (
          SELECT product_id, SUM(quantity) AS total_quantity_purchased, SUM(total_cost) AS total_cost_purchased
          FROM purchases
          WHERE status='active'
          GROUP BY product_id
      ) p ON s.product_id = p.product_id
      WHERE DATE(s.sale_date, 'unixepoch', 'localtime') BETWEEN ? AND ?
        AND s.status = 'active'
        AND s.purchase_id IS NULL        
        GROUP BY s.product_id, s.alias_product_name, p.total_quantity_purchased, p.total_cost_purchased;
    ''',
      variables: [Variable.withString(startDate), Variable.withString(endDate)],
      readsFrom: {sales, db.purchases},
    ).get();

    return result.map((row) {
      final totalQuantityPurchased =
          (row.data['total_quantity_purchased'] as num?)?.toDouble() ?? 0.0;
      final totalCostPurchased =
          (row.data['total_cost_purchased'] as num?)?.toDouble() ?? 0.0;
      final avgCostPerUnit = totalQuantityPurchased > 0
          ? totalCostPurchased / totalQuantityPurchased
          : 0.0;

      final totalQuantitySold =
          (row.data['total_quantity_sold'] as num?)?.toDouble() ?? 0.0;
      final totalSales = (row.data['total_sales'] as num?)?.toDouble() ?? 0.0;

      final costOfGoodsSold = totalQuantitySold * avgCostPerUnit;
      final profit = totalSales - costOfGoodsSold;

      return ProductProfit(
        productId: row.data['product_id'] as int,
        productName: row.data['product'] as String,
        totalQuantitySold: totalQuantitySold,
        totalSales: totalSales,
        avgCost: avgCostPerUnit,
        profit: profit,
      );
    }).toList();
  }
}
