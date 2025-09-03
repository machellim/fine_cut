import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/sales_table.dart';

part 'sale_dao.g.dart';

@DriftAccessor(tables: [Sales])
class SaleDao extends DatabaseAccessor<AppDatabase> with _$SaleDaoMixin {
  final AppDatabase db;

  SaleDao(this.db) : super(db);

  Future<List<Sale>> getAllSales() {
    return (select(sales)
          ..where((t) => t.status.equals('active'))
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> createOrUpdateSale(
    SalesCompanion saleCompanion,
    RecordAction recordAction,
    Product selectedProduct,
  ) async {
    if (recordAction == RecordAction.create) {
      saleCompanion = saleCompanion.copyWith(
        aliasProductName: Value(selectedProduct.name),
      );

      return into(sales).insert(saleCompanion);
    } else {
      final id = saleCompanion.id.value;
      final rowsUpdated = await (update(
        sales,
      )..where((tbl) => tbl.id.equals(id))).write(saleCompanion);
      return rowsUpdated > 0
          ? id
          : -1; // retorna id actualizado o -1 si no existe
    }
  }

  Future<int> softDeleteSale(int id) {
    return (update(sales)..where((t) => t.id.equals(id))).write(
      SalesCompanion(status: Value(RecordStatus.deleted)),
    );
  }
}
