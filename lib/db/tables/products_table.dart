import 'package:drift/drift.dart';

enum ProductStatus { active, inactive }

class Products extends Table {
  // Primary key auto-increment
  IntColumn get id => integer().autoIncrement()();

  // Foreign key reference to Categories table
  IntColumn get categoryId => integer()
      .named('category_id')
      .customConstraint('REFERENCES categories(id) ON DELETE CASCADE')();

  // Product name (e.g., "Beef", "Salt")
  TextColumn get name => text()
      .withLength(min: 1, max: 300)
      .named('name')
      .customConstraint('UNIQUE')();

  // Product description (optional)
  TextColumn get description =>
      text().withLength(min: 0, max: 1000).nullable().named('description')();

  // Selling price per unit, including tax
  RealColumn get sellingPrice =>
      real().named('selling_price').withDefault(const Constant(0.0))();

  // Product stock quantity
  IntColumn get stock =>
      integer().named('stock').withDefault(const Constant(0))();

  // Whether to track stock for this product
  BoolColumn get trackStock => boolean().withDefault(const Constant(true))();

  // Active/inactive status
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(ProductStatus.values))
      .withDefault(const Constant('active'))();

  // Creation date, defaults to current date and time
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date (nullable, will be updated manually in DAO)
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();
}
