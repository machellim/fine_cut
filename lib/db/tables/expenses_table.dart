import 'package:drift/drift.dart';

enum ExpenseStatus { active, deleted }

class Expenses extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Foreign key to cash register for daily expenses
  IntColumn get cashRegisterId => integer()
      .nullable()
      .named('cash_register_id')
      .customConstraint('REFERENCES cash_registers(id) ON DELETE SET NULL')();

  // Expense description (e.g., "Electricity bill", "Transport")
  TextColumn get description =>
      text().withLength(min: 1, max: 1000).named('description')();

  // Amount spent
  RealColumn get amount =>
      real().named('amount').withDefault(const Constant(0.0))();

  // Optional notes
  TextColumn get notes =>
      text().nullable().named('notes').withLength(min: 0, max: 1000)();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(ExpenseStatus.values))
      .withDefault(const Constant('active'))();

  // Date of the expense
  DateTimeColumn get expenseDate =>
      dateTime().named('expense_date').withDefault(currentDateAndTime)();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
