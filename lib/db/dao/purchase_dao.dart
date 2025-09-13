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

  /*Future<int> createOrUpdatePurchase(
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
  }*/

  Future<int> createOrUpdatePurchase(
    PurchasesCompanion purchaseCompanion,
    RecordAction recordAction,
    Product selectedProduct,
  ) async {
    // Wrap everything in a transaction to ensure atomicity
    return await transaction(() async {
      if (recordAction == RecordAction.create) {
        final dateHour = AppUtils.getFormatDateHour();

        // Set alias name for the product
        if (selectedProduct.hasSubProducts) {
          purchaseCompanion = purchaseCompanion.copyWith(
            aliasProductName: Value('${selectedProduct.name} $dateHour'),
          );
        } else {
          purchaseCompanion = purchaseCompanion.copyWith(
            aliasProductName: Value(selectedProduct.name),
          );
        }

        // Insert the new purchase
        final purchaseId = await into(purchases).insert(purchaseCompanion);

        // Update the product stock after creating the purchase
        if (selectedProduct.trackStock) {
          await db.productDao.updateStockProduct(
            productId: selectedProduct.id,
            quantityChange:
                purchaseCompanion.quantity.value, // add purchased quantity
          );
        }

        return purchaseId;
      } else {
        final id = purchaseCompanion.id.value;

        // Get the previous purchase to calculate the stock difference
        final previousPurchase = await (select(
          purchases,
        )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

        // Update the purchase record
        final rowsUpdated = await (update(
          purchases,
        )..where((tbl) => tbl.id.equals(id))).write(purchaseCompanion);

        if (rowsUpdated > 0 && previousPurchase != null) {
          // Update the product stock based on the difference
          if (selectedProduct.trackStock) {
            // Calculate the difference in quantity between new and previous purchase
            final quantityDiff =
                purchaseCompanion.quantity.value - previousPurchase.quantity;

            await db.productDao.updateStockProduct(
              productId: selectedProduct.id,
              quantityChange: quantityDiff,
            );
          }
        }

        return rowsUpdated > 0
            ? id
            : -1; // return updated id or -1 if not found
      }
    });
  }

  // function to update purchase as deleted if it has not references from sales
  Future<int> softDeletePurchaseIfNoSales(int purchaseId) {
    return transaction(() async {
      // 1. Check if there is at least one sale referencing this purchase
      final saleExists =
          await (select(db.sales)
                ..where((s) => s.purchaseId.equals(purchaseId))
                ..limit(1))
              .getSingleOrNull();

      if (saleExists != null) {
        return 0; // Cannot delete, purchase has related sales
      }

      // 2. Get the purchase record
      final purchase = await (select(
        purchases,
      )..where((p) => p.id.equals(purchaseId))).getSingleOrNull();
      if (purchase == null) return -1;

      // 3. Get the product associated with this purchase
      final product = await (select(
        db.products,
      )..where((p) => p.id.equals(purchase.productId))).getSingleOrNull();
      if (product == null) return -1;

      // 4. Soft delete the purchase (set status to deleted)
      final rowsUpdated =
          await (update(purchases)..where((p) => p.id.equals(purchaseId)))
              .write(PurchasesCompanion(status: Value(RecordStatus.deleted)));

      // 5. Update stock (if the product tracks stock)
      if (rowsUpdated > 0 && product.trackStock) {
        await db.productDao.updateStockProduct(
          productId: product.id,
          quantityChange:
              -purchase.quantity, // revert purchase → decrease stock
        );
      }

      return rowsUpdated > 0 ? purchaseId : -1;
    });
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
