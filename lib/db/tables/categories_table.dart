import 'package:drift/drift.dart';

enum CategoryStatus { active, inactive }

class Categories extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Category name (e.g., "Meat", "Condiments")
  TextColumn get name => text()
      .withLength(min: 1, max: 100)
      .named('name')
      .customConstraint('UNIQUE')();

  // Optional description
  TextColumn get description =>
      text().withLength(min: 0, max: 1000).nullable().named('description')();

  // Active/inactive status (soft delete instead of removing data)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(CategoryStatus.values))
      .withDefault(const Constant('active'))();

  // Creation date, defaults to current date and time
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date, defaults to current date and time
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
