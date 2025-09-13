import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/sales_table.dart';

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
}
