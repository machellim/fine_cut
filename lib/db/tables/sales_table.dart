import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart' show RecordStatus;

class Sales extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Foreign key to the product sold
  IntColumn get productId => integer()
      .named('product_id')
      .customConstraint('REFERENCES products(id) ON DELETE CASCADE')();

  // Foreign key to the specific purchase (if applicable),
  // only to products that track stock (i.e., trackStock = false)
  IntColumn get purchaseId => integer()
      .nullable()
      .named('purchase_id')
      .customConstraint('REFERENCES purchases(id) ON DELETE SET NULL')();

  // Reference to cash register for daily sales
  IntColumn get cashRegisterId => integer()
      .nullable()
      .named('cash_register_id')
      .customConstraint('REFERENCES cash_registers(id) ON DELETE SET NULL')();

  // Reference to payment method used
  IntColumn get paymentMethodId => integer()
      .named('payment_method_id')
      .customConstraint('REFERENCES payment_methods(id) ON DELETE SET NULL')();

  // Quantity sold
  RealColumn get quantity =>
      real().named('quantity').withDefault(const Constant(0.0))();

  // Total price of the sale
  RealColumn get totalPrice =>
      real().named('total_price').withDefault(const Constant(0.0))();

  // Optional notes about the sale
  TextColumn get notes =>
      text().nullable().named('notes').withLength(min: 0, max: 1000)();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(RecordStatus.values))
      .withDefault(Constant(RecordStatus.active.name))();

  // Date of the sale
  DateTimeColumn get saleDate =>
      dateTime().named('sale_date').withDefault(currentDateAndTime)();

  // Creation date
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
