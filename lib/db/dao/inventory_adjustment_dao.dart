import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/inventory_adjustments_table.dart';

part 'inventory_adjustment_dao.g.dart';

@DriftAccessor(tables: [InventoryAdjustments])
class InventoryAdjustmentDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryAdjustmentDaoMixin {
  final AppDatabase db;

  InventoryAdjustmentDao(this.db) : super(db);
  Future<List<InventoryAdjustment>> getAllInventoryAdjustments() {
    return (select(inventoryAdjustments)
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<AdjustmentType>> searchAdjustmentTypes(String filter) {
    return (select(db.adjustmentTypes)
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.asc(t.increasesStock)]))
        .get();
  }

  Future<int> createOrUpdateInventoryAdjustment(
    InventoryAdjustmentsCompanion inventoryAdjustmentCompanion,
    RecordAction recordAction,
  ) async {
    if (recordAction == RecordAction.create) {
      return into(inventoryAdjustments).insert(inventoryAdjustmentCompanion);
    } else {
      final id = inventoryAdjustmentCompanion.id.value;
      final rowsUpdated = await (update(
        inventoryAdjustments,
      )..where((tbl) => tbl.id.equals(id))).write(inventoryAdjustmentCompanion);
      return rowsUpdated > 0 ? id : -1;
    }
  }

  Future<int> softDeleteInventoryAdjustment(int id) {
    return (update(inventoryAdjustments)..where((t) => t.id.equals(id))).write(
      InventoryAdjustmentsCompanion(status: Value(RecordStatus.deleted)),
    );
  }
}
