import 'package:drift/drift.dart';

// Table definition for global settings
class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Key name of the setting (e.g., "iva", "company_email")
  TextColumn get key => text().unique()();

  // Stored value (always saved as text for flexibility)
  TextColumn get value => text()();

  // Optional description for clarity
  TextColumn get description => text().nullable()();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
