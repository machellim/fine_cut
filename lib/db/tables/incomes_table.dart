import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart';

class Incomes extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Foreign key to cash register for daily expenses
  IntColumn get cashRegisterId => integer()
      .nullable()
      .named('cash_register_id')
      .customConstraint('REFERENCES cash_registers(id) ON DELETE SET NULL')();

  // Amount of income
  RealColumn get amount => real()();

  TextColumn get description =>
      text().withLength(min: 1, max: 1000).named('description')();

  // Status: active/deleted (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(RecordStatus.values))
      .withDefault(Constant(RecordStatus.active.name))();

  // Date of the income
  DateTimeColumn get incomeDate =>
      dateTime().named('income_date').withDefault(currentDateAndTime)();

  // Creation date, defaults to current date and time
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
