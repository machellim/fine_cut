import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart' show AppActiveStatus;

class Units extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Unit name (e.g., "Kilogram", "Pound", "Ounce", "Package")
  TextColumn get name => text()
      .withLength(min: 1, max: 50)
      .named('name')
      .customConstraint('UNIQUE')();

  // Short symbol (e.g., "kg", "lb", "oz", "pkg")
  TextColumn get symbol => text().withLength(min: 1, max: 10).named('symbol')();

  // Status to handle soft delete
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(AppActiveStatus.values))
      .withDefault(Constant(AppActiveStatus.active.name))();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
