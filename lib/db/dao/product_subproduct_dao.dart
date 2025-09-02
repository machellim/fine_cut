import 'package:drift/drift.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/product_subproducts_table.dart';

part 'product_subproduct_dao.g.dart';

@DriftAccessor(tables: [ProductSubproducts])
class ProductSubproductDao extends DatabaseAccessor<AppDatabase>
    with _$ProductSubproductDaoMixin {
  final AppDatabase db;

  ProductSubproductDao(this.db) : super(db);
}
