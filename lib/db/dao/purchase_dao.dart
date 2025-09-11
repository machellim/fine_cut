import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/purchases_table.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(tables: [Purchases])
class PurchaseDao extends DatabaseAccessor<AppDatabase>
    with _$PurchaseDaoMixin {
  final AppDatabase db;

  PurchaseDao(this.db) : super(db);

  Future<List<Purchase>> getPurchasesByCashRegisterId(int cashRegisterId) {
    return (select(purchases)
          ..where(
            (t) =>
                t.status.equals('active') &
                t.cashRegisterId.equals(cashRegisterId),
          )
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<Purchase?> getById(int id) {
    return (select(purchases)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<int> createOrUpdatePurchase(
    PurchasesCompanion purchaseCompanion,
    RecordAction recordAction,
    Product selectedProduct,
  ) async {
    if (recordAction == RecordAction.create) {
      final dateHour = AppUtils.getFormatDateHour();
      if (selectedProduct.hasSubProducts) {
        purchaseCompanion = purchaseCompanion.copyWith(
          aliasProductName: Value('${selectedProduct.name} $dateHour'),
        );
      } else {
        purchaseCompanion = purchaseCompanion.copyWith(
          aliasProductName: Value(selectedProduct.name),
        );
      }

      return into(purchases).insert(purchaseCompanion);
    } else {
      final id = purchaseCompanion.id.value;
      final rowsUpdated = await (update(
        purchases,
      )..where((tbl) => tbl.id.equals(id))).write(purchaseCompanion);
      return rowsUpdated > 0
          ? id
          : -1; // retorna id actualizado o -1 si no existe
    }
  }

  // function to update purchase as deleted if it has not refreneces from sales
  Future<int> softDeletePurchaseIfNoSales(int purchaseId) async {
    // Check if there is at least one sale referencing this purchase
    final saleExists =
        await (select(db.sales)
              ..where((s) => s.purchaseId.equals(purchaseId))
              ..limit(1))
            .getSingleOrNull(); // safe now, max 1 record

    if (saleExists != null) {
      return 0; // Cannot delete, purchase has related sales
    }

    // No sales found → perform soft delete
    return (update(purchases)..where((p) => p.id.equals(purchaseId))).write(
      PurchasesCompanion(status: Value(RecordStatus.deleted)),
    );
  }

  /*Future<List<Purchase>> getPurchasesWithSubproducts() async {
    final query =
        select(purchases).join([
            innerJoin(
              db.products,
              db.products.id.equalsExp(purchases.productId),
            ),
          ])
          ..where(db.products.hasSubProducts.equals(true))
          ..limit(AppConstants.listResultsLimit);

    final results = await query.map((row) => row.readTable(purchases)).get();

    return results;
  }*/

  Future<List<Purchase>> getPurchasesWithSubproducts() async {
    final query =
        select(purchases).join([
            innerJoin(
              db.products,
              db.products.id.equalsExp(purchases.productId),
            ),
          ])
          ..where(
            db.products.hasSubProducts.equals(true) &
                purchases.status.equals('active'),
          )
          ..orderBy([
            OrderingTerm(
              expression: purchases.createdAt,
              mode: OrderingMode.desc,
            ),
          ])
          ..limit(AppConstants.listResultsLimit);

    final results = await query.map((row) => row.readTable(purchases)).get();

    return results;
  }

  Future<List<Purchase>> getParentProductStockList() {
    return (select(purchases)
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> updateSoldOutStatus(int purchaseId, bool isSoldOut) {
    return (update(purchases)..where((tbl) => tbl.id.equals(purchaseId))).write(
      PurchasesCompanion(isSoldOut: Value(isSoldOut)),
    );
  }
}
