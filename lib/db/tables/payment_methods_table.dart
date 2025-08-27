import 'package:drift/drift.dart';
import 'package:fine_cut/db/enums.dart' show AppActiveStatus;

class PaymentMethods extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Payment method name (e.g., "Cash", "Credit Card", "Mobile Payment")
  TextColumn get name =>
      text().withLength(min: 1, max: 50).customConstraint('UNIQUE')();

  TextColumn get description => text().nullable()();

  // Order to display the unit in UI
  IntColumn get displayOrder =>
      integer().named('display_order').withDefault(const Constant(0))();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(AppActiveStatus.values))
      .withDefault(Constant(AppActiveStatus.active.name))();

  // Creation date, defaults to current date and time
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date (nullable, will be updated manually in DAO)
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
