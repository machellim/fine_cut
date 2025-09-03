import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import '../database.dart';

import '../tables/products_table.dart';
import '../tables/product_subproducts_table.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products, ProductSubproducts])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase db;

  ProductDao(this.db) : super(db);

  Future<List<Product>> getAllProducts() {
    return (select(products)
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<Product?> getById(int id) {
    return (select(products)..where((c) => c.id.equals(id))).getSingleOrNull();
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

  /*Future<Product?> createProduct({
    required int categoryId,
    required String name,
    required bool hasSubProducts,
    String? description,
    bool? trackStock,
  }) async {
    if (await _isNameTaken(name)) return null;

    final companion = ProductsCompanion.insert(
      categoryId: categoryId,
      name: name,
      hasSubProducts: Value(hasSubProducts),
      description: Value(description),
      trackStock: Value(trackStock ?? true),
    );
    return await into(products).insertReturning(companion);
  }*/

  Future<Product?> createProduct({
    required int categoryId,
    required String name,
    required bool hasSubProducts,
    String? description,
    bool? trackStock,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    if (await _isNameTaken(name)) return null;

    return await transaction(() async {
      // Insert main product
      final productCompanion = ProductsCompanion.insert(
        categoryId: categoryId,
        name: name,
        hasSubProducts: Value(hasSubProducts),
        description: Value(description),
        trackStock: Value(trackStock ?? true),
      );

      final product = await into(products).insertReturning(productCompanion);

      // Insert subproducts if any
      if (subproducts.isNotEmpty) {
        final subproductCompanions = subproducts.map((sp) {
          return ProductSubproductsCompanion.insert(
            productId: product.id,
            subproductId: sp.subproductId.value, // ya viene con Value()
          );
        }).toList();

        await batch((batch) {
          batch.insertAll(db.productSubproducts, subproductCompanions);
        });
      }

      return product;
    });
  }

  /*Future<Product?> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required bool hasSubProducts,
    String? description,
    AppActiveStatus status = AppActiveStatus.active,
    bool? trackStock,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    if (await _isNameTaken(name, excludeId: id)) return null;

    final companion = ProductsCompanion(
      categoryId: Value(categoryId),
      name: Value(name),
      hasSubProducts: Value(hasSubProducts),
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
  }*/

  Future<Product?> updateProduct({
    required int id,
    required int categoryId,
    required String name,
    required bool hasSubProducts,
    String? description,
    AppActiveStatus status = AppActiveStatus.active,
    bool? trackStock,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    if (await _isNameTaken(name, excludeId: id)) return null;

    final companion = ProductsCompanion(
      categoryId: Value(categoryId),
      name: Value(name),
      hasSubProducts: Value(hasSubProducts),
      description: Value(description),
      status: Value(status),
      trackStock: Value(trackStock ?? true),
    );

    return await transaction(() async {
      // Actualizar producto
      await (update(
        products,
      )..where((tbl) => tbl.id.equals(id))).write(companion);

      // Eliminar subproductos antiguos
      await (delete(
        db.productSubproducts,
      )..where((tbl) => tbl.productId.equals(id))).go();

      // Insertar nuevos subproductos usando batch
      if (subproducts.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(
            db.productSubproducts,
            subproducts.map((c) => c.copyWith(productId: Value(id))).toList(),
          );
        });
      }

      // Retornar producto actualizado
      return await (select(
        products,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    });
  }

  Future<List<Product>> searchProducts(String query) {
    final trimmedQuery = query.trim();

    // Filter products in the database with status = active
    return (select(products)
          ..where(
            (c) =>
                c.name.lower().like('%${trimmedQuery.toLowerCase()}%') &
                (c.status.equals(AppActiveStatus.active.name)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.name)])
          ..limit(AppConstants.searchResultsLimit))
        .get();
  }

  Future<List<Product>> getSubproductsByProduct(Product product) {
    final query = (select(db.products).join([
      innerJoin(
        db.productSubproducts,
        db.productSubproducts.subproductId.equalsExp(db.products.id),
      ),
    ])..where(db.productSubproducts.productId.equals(product.id)));

    return query.map((row) => row.readTable(db.products)).get();
  }
}
