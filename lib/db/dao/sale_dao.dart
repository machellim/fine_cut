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
  ) async {
    saleCompanion = saleCompanion.copyWith(
      aliasProductName: Value(selectedProduct.name),
    );
    if (recordAction == RecordAction.create) {
      return into(sales).insert(saleCompanion);
    } else {
      final id = saleCompanion.id.value;
      final rowsUpdated = await (update(
        sales,
      )..where((tbl) => tbl.id.equals(id))).write(saleCompanion);
      return rowsUpdated > 0
          ? id
          : -1; // retorna id actualizado o -1 si no existe
    }
  }

  Future<int> softDeleteSale(int id) {
    return (update(sales)..where((t) => t.id.equals(id))).write(
      SalesCompanion(status: Value(RecordStatus.deleted)),
    );
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
          ..where(db.purchases.isSoldOut.equals(false));
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
    return (select(sales)..where((s) => s.purchaseId.equals(purchaseId))).get();
  }

  Future<bool> existsAsSubproduct(int productId) async {
    final query = select(db.productSubproducts)
      ..where((tbl) => tbl.subproductId.equals(productId));

    final result = await query.getSingleOrNull();
    return result != null;
  }
}
