import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/expenses_table.dart';
import 'package:fine_cut/db/tables/incomes_table.dart';

part 'income_dao.g.dart';

@DriftAccessor(tables: [Incomes])
class IncomeDao extends DatabaseAccessor<AppDatabase> with _$IncomeDaoMixin {
  final AppDatabase db;

  IncomeDao(this.db) : super(db);
  Future<List<Income>> getIncomesByCashRegisterId(int cashRegisterId) {
    return (select(incomes)
          ..where(
            (t) =>
                t.status.equals(AppActiveStatus.active.name) &
                t.cashRegisterId.equals(cashRegisterId),
          )
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> createOrUpdateIncome(
    IncomesCompanion incomeCompanion,
    RecordAction recordAction,
  ) async {
    if (recordAction == RecordAction.create) {
      return into(incomes).insert(incomeCompanion);
    } else {
      final id = incomeCompanion.id.value;
      final rowsUpdated = await (update(
        incomes,
      )..where((tbl) => tbl.id.equals(id))).write(incomeCompanion);
      return rowsUpdated > 0 ? id : -1;
    }
  }

  Future<int> softDeleteIncomee(int id) {
    return (update(incomes)..where((t) => t.id.equals(id))).write(
      IncomesCompanion(status: Value(RecordStatus.deleted)),
    );
  }
}
