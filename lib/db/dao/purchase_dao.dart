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

  Future<int> softDeletePurchase(int id) {
    return (update(purchases)..where((t) => t.id.equals(id))).write(
      PurchasesCompanion(status: Value(RecordStatus.deleted)),
    );
  }

  Future<List<Purchase>> getPurchasesWithSubproducts() async {
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
  }
}
