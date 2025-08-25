import 'package:drift/drift.dart';
import 'package:fine_cut/db/enums.dart' show CashRegisterStatus;

class CashRegisters extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Date of the register (e.g., 2025-08-24)
  DateTimeColumn get registerDate =>
      dateTime().named('register_date').withDefault(currentDateAndTime)();

  // Opening amount for the day
  RealColumn get openingAmount =>
      real().named('opening_amount').withDefault(const Constant(0.0))();

  // Closing amount for the day (to be updated at end of day)
  RealColumn get closingAmount => real().nullable().named('closing_amount')();

  // Total sales amount (can be calculated from Sales table)
  RealColumn get totalSales =>
      real().named('total_sales').withDefault(const Constant(0.0))();

  // Total expenses for the day (can be calculated from Expenses table)
  RealColumn get totalExpenses =>
      real().named('total_expenses').withDefault(const Constant(0.0))();

  // Status: open/closed
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(CashRegisterStatus.values))
      .withDefault(Constant(CashRegisterStatus.open.name))();

  // Optional notes or description about the cash register
  TextColumn get notes =>
      text().nullable().named('notes').withLength(min: 0, max: 1000)();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
