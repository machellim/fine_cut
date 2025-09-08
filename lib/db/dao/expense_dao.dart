import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/expenses_table.dart';

part 'expense_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpenseDao extends DatabaseAccessor<AppDatabase> with _$ExpenseDaoMixin {
  final AppDatabase db;

  ExpenseDao(this.db) : super(db);

  Future<List<Expense>> getExpensesByCashRegisterId(int cashRegisterId) {
    return (select(expenses)
          ..where(
            (t) =>
                t.status.equals(AppActiveStatus.active.name) &
                t.cashRegisterId.equals(cashRegisterId),
          )
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> createOrUpdateExpense(
    ExpensesCompanion expenseCompanion,
    RecordAction recordAction,
  ) async {
    if (recordAction == RecordAction.create) {
      return into(expenses).insert(expenseCompanion);
    } else {
      final id = expenseCompanion.id.value;
      final rowsUpdated = await (update(
        expenses,
      )..where((tbl) => tbl.id.equals(id))).write(expenseCompanion);
      return rowsUpdated > 0
          ? id
          : -1; // retorna id actualizado o -1 si no existe
    }
  }

  Future<int> softDeleteExpense(int id) {
    return (update(expenses)..where((t) => t.id.equals(id))).write(
      ExpensesCompanion(status: Value(RecordStatus.deleted)),
    );
  }
}
