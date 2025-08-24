import 'package:drift/drift.dart';

class Incomes extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Foreign key to cash register for daily expenses
  IntColumn get cashRegisterId => integer()
      .nullable()
      .named('cash_register_id')
      .customConstraint('REFERENCES cash_registers(id) ON DELETE SET NULL')();

  // Amount of income
  RealColumn get amount => real()();

  TextColumn get description => text().nullable()();

  // Creation date, defaults to current date and time
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
