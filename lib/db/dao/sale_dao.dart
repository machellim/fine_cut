import 'package:drift/drift.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/sales_table.dart';

part 'sale_dao.g.dart';

@DriftAccessor(tables: [Sales])
class SaleDao extends DatabaseAccessor<AppDatabase> with _$SaleDaoMixin {
  final AppDatabase db;

  SaleDao(this.db) : super(db);
}
