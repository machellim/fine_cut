import 'package:drift/drift.dart';

class ProductSubproducts extends Table {
  // Reference to the parent product
  IntColumn get productId =>
      integer().customConstraint('REFERENCES products(id) ON DELETE CASCADE')();

  // Reference to the subproduct
  IntColumn get subproductId =>
      integer().customConstraint('REFERENCES products(id) ON DELETE CASCADE')();

  @override
  Set<Column> get primaryKey => {productId, subproductId};
}
