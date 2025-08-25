import 'package:drift/drift.dart';
import 'package:fine_cut/db/enums.dart' show AppActiveStatus;

class ProductUnits extends Table {
  IntColumn get id => integer().autoIncrement()();

  // FK to product
  IntColumn get productId =>
      integer().customConstraint('REFERENCES products(id) ON DELETE CASCADE')();

  // FK to unit
  IntColumn get unitId =>
      integer().customConstraint('REFERENCES units(id) ON DELETE CASCADE')();

  // Price per this unit
  RealColumn get price =>
      real().named('price').withDefault(const Constant(0.0))();

  // Optional stock for this unit
  RealColumn get stock =>
      real().named('stock').withDefault(const Constant(0.0))();

  // Order to display the unit in UI
  IntColumn get displayOrder =>
      integer().named('display_order').withDefault(const Constant(0))();

  // Status: active/inactive (soft delete)
  TextColumn get status => text()
      .named('status')
      .withLength(min: 1, max: 50)
      .map(const EnumNameConverter(AppActiveStatus.values))
      .withDefault(Constant(AppActiveStatus.active.name))();

  // Creation date, defaults to current date and time
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  // Last updated date (nullable, will be updated manually in DAO)
  DateTimeColumn get updatedAt => dateTime().nullable().named('updated_at')();

  // Unique constraint to prevent duplicate product-unit combinations
  @override
  List<Set<Column>> get uniqueKeys => [
    {productId, unitId},
  ];
}
