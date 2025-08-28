import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart';
import '../database.dart';

import '../tables/products_table.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase db;

  ProductDao(this.db) : super(db);

  Future<List<Product>> getAllProducts() {
    return (select(products)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Future<bool> _isNameTaken(String name, {int? excludeId}) async {
    final normalizedName = name.toLowerCase();
    final conflict =
        await (select(products)
              ..where((tbl) => tbl.name.lower().equals(normalizedName)))
            .getSingleOrNull();

    if (conflict == null) return false;
    if (excludeId != null && conflict.id == excludeId) return false;
    return true;
  }

  Future<Product?> createProduct({
    required int categoryId,
    required String name,
    String? description,
    bool? trackStock,
  }) async {
    if (await _isNameTaken(name)) return null;

    final companion = ProductsCompanion.insert(
      categoryId: categoryId,
      name: name,
      description: Value(description),
      trackStock: Value(trackStock ?? true),
    );
    return await into(products).insertReturning(companion);
  }

  Future<Product?> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    String? description,
    AppActiveStatus status = AppActiveStatus.active,
    bool? trackStock,
  }) async {
    if (await _isNameTaken(name, excludeId: id)) return null;

    final companion = ProductsCompanion(
      categoryId: Value(categoryId),
      name: Value(name),
      description: Value(description),
      status: Value(status),
      trackStock: Value(trackStock ?? true),
    );

    await (update(
      products,
    )..where((tbl) => tbl.id.equals(id))).write(companion);

    return await (select(
      products,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
