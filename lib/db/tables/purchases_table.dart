import 'package:drift/drift.dart';

enum PurchaseStatus { active, deleted }

class Purchases extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Foreign key to the product being purchased
  IntColumn get productId => integer()
      .named('product_id')
      .customConstraint('REFERENCES products(id) ON DELETE CASCADE')();

  // Optional reference to unit used for the purchase
  IntColumn get unitId => integer()
      .nullable()
      .named('unit_id')
      .customConstraint('REFERENCES units(id) ON DELETE SET NULL')();

  // Quantity purchased
  RealColumn get quantity =>
      real().named('quantity').withDefault(const Constant(0.0))();

  // Total cost = quantity * pricePerUnit
  RealColumn get totalCost =>
      real().named('total_cost').withDefault(const Constant(0.0))();

  // Date of purchase
  DateTimeColumn get purchaseDate =>
      dateTime().named('purchase_date').withDefault(currentDateAndTime)();

  // Optional notes about the purchase
  TextColumn get notes =>
      text().nullable().named('notes').withLength(min: 0, max: 1000)();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(PurchaseStatus.values))
      .withDefault(const Constant('active'))();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
