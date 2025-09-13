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
    double? salePrice,
    bool? trackStock,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    // Check if the name is already taken
    if (await _isNameTaken(name)) return null;

    return await transaction(() async {
      // Insert main product
      final productCompanion = ProductsCompanion.insert(
        categoryId: categoryId,
        name: name,
        hasSubProducts: Value(hasSubProducts),
        description: Value(description),
        salePrice: Value(salePrice ?? 0),
        trackStock: Value(trackStock ?? true),
      );

      final product = await into(products).insertReturning(productCompanion);

      // Insert subproducts if any
      if (hasSubProducts && subproducts.isNotEmpty) {
        final subproductCompanions = subproducts.map((sp) {
          return ProductSubproductsCompanion.insert(
            productId: product.id,
            subproductId: sp.subproductId.value,
          );
        }).toList();

        await batch((batch) {
          batch.insertAll(db.productSubproducts, subproductCompanions);
        });
      }

      return product;
    });
  }*/

  Future<Product?> createProduct({
    required ProductsCompanion productCompanion,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    // Check if the name is already taken
    if (await _isNameTaken(productCompanion.name.value)) return null;

    return await transaction(() async {
      if (productCompanion.hasSubProducts.value) {
        productCompanion = productCompanion.copyWith(trackStock: Value(false));
        // Update subproducts trackStock
        await batch((batch) {
          batch.update(
            db.products,
            ProductsCompanion(trackStock: Value(false)),
            where: (tbl) => tbl.id.isIn(
              subproducts.map((sp) => sp.subproductId.value).toList(),
            ),
          );
        });
      }
      // Insert main product
      final product = await into(products).insertReturning(productCompanion);

      // Insert subproducts if any
      if (productCompanion.hasSubProducts.value && subproducts.isNotEmpty) {
        final subproductCompanions = subproducts.map((sp) {
          return ProductSubproductsCompanion.insert(
            productId: product.id,
            subproductId: sp.subproductId.value,
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
    double? salePrice,
    AppActiveStatus status = AppActiveStatus.active,
    bool? trackStock,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    // Check if the name is already taken (excluding current product ID)
    if (await _isNameTaken(name, excludeId: id)) return null;

    final companion = ProductsCompanion(
      categoryId: Value(categoryId),
      name: Value(name),
      hasSubProducts: Value(hasSubProducts),
      description: Value(description),
      salePrice: Value(salePrice ?? 0),
      status: Value(status),
      trackStock: Value(trackStock ?? true),
    );

    return await transaction(() async {
      // Update product
      await (update(
        products,
      )..where((tbl) => tbl.id.equals(id))).write(companion);

      await (delete(
        db.productSubproducts,
      )..where((tbl) => tbl.productId.equals(id))).go();

      // If product supports subproducts, insert new ones
      if (hasSubProducts && subproducts.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(
            db.productSubproducts,
            subproducts.map((c) => c.copyWith(productId: Value(id))).toList(),
          );
        });
      }

      // Return updated product
      return await (select(
        products,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    });
  }*/

  Future<Product?> updateProduct({
    required ProductsCompanion productCompanion,
    List<ProductSubproductsCompanion> subproducts = const [],
  }) async {
    // Check if the name is already taken (excluding current product ID)
    if (await _isNameTaken(
      productCompanion.name.value,
      excludeId: productCompanion.id.value,
    )) {
      return null;
    }

    return await transaction(() async {
      // Update trackStock
      if (productCompanion.hasSubProducts.value) {
        productCompanion = productCompanion.copyWith(trackStock: Value(false));
      } else if (!productCompanion.hasSubProducts.value) {
        bool isSubproduct = await isProductInSubproducts(
          productCompanion.id.value,
        );
        if (!isSubproduct) {
          productCompanion = productCompanion.copyWith(trackStock: Value(true));
        }
      }
      // Update product
      await (update(products)
            ..where((tbl) => tbl.id.equals(productCompanion.id.value)))
          .write(productCompanion);

      await (delete(
        db.productSubproducts,
      )..where((tbl) => tbl.productId.equals(productCompanion.id.value))).go();

      // If product supports subproducts, insert new ones
      if (productCompanion.hasSubProducts.value && subproducts.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(
            db.productSubproducts,
            subproducts
                .map(
                  (c) =>
                      c.copyWith(productId: Value(productCompanion.id.value)),
                )
                .toList(),
          );
        });
      }

      // Update subproducts trackStock
      if (productCompanion.hasSubProducts.value) {
        await batch((batch) {
          batch.update(
            db.products,
            ProductsCompanion(trackStock: Value(false)),
            where: (tbl) => tbl.id.isIn(
              subproducts.map((sp) => sp.subproductId.value).toList(),
            ),
          );
        });
      } else if (!productCompanion.hasSubProducts.value) {
        await batch((batch) {
          batch.update(
            db.products,
            ProductsCompanion(trackStock: Value(true)),
            where: (tbl) => tbl.id.isIn(
              subproducts.map((sp) => sp.subproductId.value).toList(),
            ),
          );
        });
      }

      // Return updated product
      return await (select(products)
            ..where((tbl) => tbl.id.equals(productCompanion.id.value)))
          .getSingleOrNull();
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

  Future<List<Product>> searchSubProducts(String query) {
    final trimmedQuery = query.trim();

    // Filter products in the database with status = active
    return (select(products)
          ..where(
            (c) =>
                c.name.lower().like('%${trimmedQuery.toLowerCase()}%') &
                (c.status.equals(AppActiveStatus.active.name) &
                    c.hasSubProducts.equals(false)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.name)])
          ..limit(AppConstants.searchResultsLimit))
        .get();
  }

  Future<List<Product>> searchSubproductsFilter(String query) {
    final trimmedQuery = query.trim();

    // Filter products in the database with status = active
    return (select(products)
          ..where(
            (c) =>
                c.name.lower().like('%${trimmedQuery.toLowerCase()}%') &
                (c.status.equals(AppActiveStatus.active.name) &
                    (c.hasSubProducts.equals(false) &
                            c.trackStock.equals(false))
                        .not()),
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

  Future<void> updateStockProduct({
    required int productId,
    required double
    quantityChange, // positive to increase, negative to decrease
  }) async {
    // Get the current stock of the product
    final product = await (select(
      products,
    )..where((tbl) => tbl.id.equals(productId))).getSingle();

    // Calculate the new stock after applying the change
    final newStock = product.stock + quantityChange;

    // Update the product's stock in the database
    await (update(products)..where((tbl) => tbl.id.equals(productId))).write(
      ProductsCompanion(stock: Value(newStock)),
    );
  }

  // function to check id a product exist in db.productSubproducts
  Future<bool> isProductInSubproducts(int productId) async {
    final product = await (select(
      db.productSubproducts,
    )..where((tbl) => tbl.subproductId.equals(productId))).getSingleOrNull();
    return product != null;
  }
}
