import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart' show RecordStatus;

class InventoryAdjustments extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Foreign key to product
  IntColumn get productId => integer()
      .named('product_id')
      .customConstraint('REFERENCES products(id) ON DELETE CASCADE')();

  // Foreign key to cash register (when the adjustment is registered)
  IntColumn get cashRegisterId => integer()
      .nullable()
      .named('cash_register_id')
      .customConstraint('REFERENCES cash_registers(id) ON DELETE SET NULL')();

  // Type of adjustment (damaged, expired, stolen, etc.)
  IntColumn get adjustmentTypeId => integer()
      .named('adjustment_type_id')
      .customConstraint('REFERENCES adjustment_types(id) ON DELETE SET NULL')();

  // Quantity of adjusted product
  RealColumn get quantity =>
      real().named('quantity').withDefault(const Constant(0.0))();

  // Optional description of the adjustment
  TextColumn get description =>
      text().nullable().named('description').withLength(min: 0, max: 1000)();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(RecordStatus.values))
      .withDefault(Constant(RecordStatus.active.name))();

  // Date of the adjustment
  DateTimeColumn get adjustmentDate =>
      dateTime().named('adjustment_date').withDefault(currentDateAndTime)();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
