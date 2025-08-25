import 'package:drift/drift.dart';
import 'package:fine_cut/db/enums.dart' show RecordStatus;

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

  // Reference to cash register for daily sales
  IntColumn get cashRegisterId => integer()
      .nullable()
      .named('cash_register_id')
      .customConstraint('REFERENCES cash_registers(id) ON DELETE SET NULL')();

  // Reference to payment method used
  IntColumn get paymentMethodId => integer()
      .named('payment_method_id')
      .customConstraint('REFERENCES payment_methods(id) ON DELETE SET NULL')();

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

  // Whether the purchased product is sold out,
  // only to products that track stock (i.e., trackStock = false)
  BoolColumn get isSoldOut =>
      boolean().named('is_sold_out').withDefault(const Constant(false))();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(RecordStatus.values))
      .withDefault(Constant(RecordStatus.active.name))();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
