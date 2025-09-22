import 'package:drift/drift.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/settings_table.dart';

part 'setting_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingDao extends DatabaseAccessor<AppDatabase> with _$SettingDaoMixin {
  final AppDatabase db;
  SettingDao(this.db) : super(db);

  // clear db
  Future<void> clearDb() async {
    await db.transaction(() async {
      await db.delete(db.cashRegisters).go();
      await db.delete(db.expenses).go();
      await db.delete(db.incomes).go();
      await db.delete(db.inventoryAdjustments).go();
      // await db.delete(db.adjustmentTypes).go();
      await db.delete(db.productSubproducts).go();
      await db.delete(db.products).go();
      await db.delete(db.purchases).go();
      await db.delete(db.sales).go();
      // await db.delete(db.paymentMethods).go();
      await db.delete(db.categories).go();
      await db.delete(db.settings).go();
    });
  }
}
