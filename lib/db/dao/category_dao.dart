import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import '../database.dart';

import '../tables/categories_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  final AppDatabase db;

  CategoryDao(this.db) : super(db);

  Future<List<Category>> getAllCategories() {
    return (select(
      categories,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Future<Category?> getById(int id) {
    return (select(
      categories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<List<Category>> searchCategories(String query) {
    final trimmedQuery = query.trim();

    // Filter categories in the database
    return (select(categories)
          ..where(
            (c) =>
                c.name.lower().like('%${trimmedQuery.toLowerCase()}%') &
                (c.status.equals(AppActiveStatus.active.name)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.name)])
          ..limit(AppConstants.searchResultsLimit))
        .get();
  }

  Future<bool> _isNameTaken(String name, {int? excludeId}) async {
    final normalizedName = name.toLowerCase();
    final conflict =
        await (select(categories)
              ..where((tbl) => tbl.name.lower().equals(normalizedName)))
            .getSingleOrNull();

    if (conflict == null) return false;
    if (excludeId != null && conflict.id == excludeId) return false;
    return true;
  }

  Future<Category?> createCategory({
    required String name,
    String? description,
  }) async {
    if (await _isNameTaken(name)) return null;

    final companion = CategoriesCompanion.insert(
      name: name,
      description: Value(description),
    );
    return await into(categories).insertReturning(companion);
  }

  Future<Category?> updateCategory({
    required int id,
    required String name,
    String? description,
    AppActiveStatus status = AppActiveStatus.active,
  }) async {
    if (await _isNameTaken(name, excludeId: id)) return null;

    final companion = CategoriesCompanion(
      name: Value(name),
      description: Value(description),
      status: Value(status),
    );

    await (update(
      categories,
    )..where((tbl) => tbl.id.equals(id))).write(companion);

    return await (select(
      categories,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
