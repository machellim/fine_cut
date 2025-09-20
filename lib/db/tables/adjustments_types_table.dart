import 'package:drift/drift.dart';

class AdjustmentTypes extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Unique name for the loss type
  TextColumn get name => text()
      .withLength(min: 1, max: 50)
      .named('name')
      .customConstraint('UNIQUE')();

  // Optional description for clarity
  TextColumn get description =>
      text().nullable().withLength(min: 0, max: 255).named('description')();

  // Indicates if this adjustment increases stock (true) or decreases stock (false)
  BoolColumn get increasesStock =>
      boolean().named('increases_stock').withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
