import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/models/cash_register_result.dart';
import 'package:intl/intl.dart';
import '../database.dart';

import '../tables/cash_registers_table.dart';

part 'cash_register_dao.g.dart';

@DriftAccessor(tables: [CashRegisters])
class CashRegisterDao extends DatabaseAccessor<AppDatabase>
    with _$CashRegisterDaoMixin {
  final AppDatabase db;

  CashRegisterDao(this.db) : super(db);

  Future<List<CashRegister>> getAllCashRegisters() {
    return (select(cashRegisters)
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.desc(t.registerDate)]))
        .get();
  }

  Future<double> getLastClosingAmount() async {
    final query = select(cashRegisters)
      ..orderBy([
        (t) =>
            OrderingTerm(expression: t.registerDate, mode: OrderingMode.desc),
      ])
      ..limit(1);

    final lastRegister = await query.getSingleOrNull();
    return lastRegister?.closingAmount ?? 0.0;
  }

  Future<Map<String, dynamic>> getDataLastCashRegister() async {
    final query = select(cashRegisters)
      ..where((tbl) => tbl.status.equals(CashRegisterStatus.closed.name))
      ..orderBy([
        (t) =>
            OrderingTerm(expression: t.registerDate, mode: OrderingMode.desc),
      ])
      ..limit(1);

    final lastRegister = await query.getSingleOrNull();

    if (lastRegister != null) {
      return {
        'closingAmount': lastRegister.closingAmount ?? 0.0,
        'nextDate': lastRegister.registerDate.add(const Duration(days: 1)),
      };
    } else {
      return {'closingAmount': 0.0, 'nextDate': DateTime.now()};
    }
  }

  Future<CashRegisterResult> createOrUpdateCashRegister({
    required String registerDateString,
    required RecordAction action,
    double? openingAmount,
    String? notes,
    int? cashRegisterId, // required if action == update
  }) async {
    // Parse the input date
    final dateFormat = DateFormat("dd-MM-yyyy");
    final parsedDate = dateFormat.parse(registerDateString);

    // Keep only Y-M-D (ignore time)
    final dateOnly = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    if (action == RecordAction.create) {
      // Get the last register (any)
      final lastRegister =
          await (select(cashRegisters)
                ..orderBy([
                  (tbl) => OrderingTerm(
                    expression: tbl.registerDate,
                    mode: OrderingMode.desc,
                  ),
                ])
                ..limit(1))
              .getSingleOrNull();

      // For CREATE: new date must not be earlier than the last existing date
      if (lastRegister != null &&
          dateOnly.isBefore(lastRegister.registerDate)) {
        return CashRegisterResult.failure(
          CashRegisterError.earlierThanLast,
          cashRegister: lastRegister,
          message: 'La fecha ingresada es menor a la última registrada.',
        );
      }

      // Only one open cash register allowed
      final openRegister =
          await (select(cashRegisters)..where(
                (tbl) => tbl.status.equals(CashRegisterStatus.open.name),
              ))
              .getSingleOrNull();

      if (openRegister != null) {
        return CashRegisterResult.failure(
          CashRegisterError.alreadyOpen,
          cashRegister: openRegister,
          message:
              'Ya existe una caja abierta en la fecha ${AppUtils.formatDate(openRegister.registerDate)}',
        );
      }

      // Prevent same-date duplication
      final existing = await (select(
        cashRegisters,
      )..where((tbl) => tbl.registerDate.equals(dateOnly))).getSingleOrNull();

      if (existing != null) {
        return CashRegisterResult.failure(
          CashRegisterError.sameDate,
          cashRegister: existing,
          message:
              'Ya existe una caja en la fecha ${AppUtils.formatDate(existing.registerDate)}',
        );
      }

      // Create
      if (openingAmount == null) {
        throw ArgumentError('openingAmount must be provided for create');
      }

      final companion = CashRegistersCompanion.insert(
        registerDate: Value(dateOnly),
        openingAmount: Value(openingAmount),
        status: Value(CashRegisterStatus.open),
        notes: Value(notes),
      );

      final newRegister = await into(cashRegisters).insertReturning(companion);
      return CashRegisterResult.success(newRegister);
    }

    // UPDATE branch
    if (cashRegisterId == null) {
      throw ArgumentError('cashRegisterId must be provided for update');
    }

    // Make sure the target register exists (optional but safer)
    final target = await (select(
      cashRegisters,
    )..where((tbl) => tbl.id.equals(cashRegisterId))).getSingleOrNull();
    if (target == null) {
      return CashRegisterResult.failure(
        CashRegisterError.notFound,
        cashRegister: null,
        message: 'La caja a actualizar no existe.',
      );
    }

    // Find the last register date among OTHER records (exclude current id)
    final lastOtherRegister =
        await (select(cashRegisters)
              ..where((tbl) => tbl.id.isNotIn([cashRegisterId]))
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.registerDate,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(1))
            .getSingleOrNull();

    // For UPDATE: new date must not be earlier than the max date of OTHER records
    if (lastOtherRegister != null &&
        dateOnly.isBefore(lastOtherRegister.registerDate)) {
      return CashRegisterResult.failure(
        CashRegisterError.earlierThanLast,
        cashRegister: lastOtherRegister,
        message:
            'La fecha ingresada es menor a la última de otros registros (${AppUtils.formatDate(lastOtherRegister.registerDate)}).',
      );
    }

    // Prevent same-date duplication with OTHER records
    final existingSameDateOther =
        await (select(cashRegisters)..where(
              (tbl) =>
                  tbl.registerDate.equals(dateOnly) &
                  tbl.id.isNotIn([cashRegisterId]),
            ))
            .getSingleOrNull();

    if (existingSameDateOther != null) {
      return CashRegisterResult.failure(
        CashRegisterError.sameDate,
        cashRegister: existingSameDateOther,
        message:
            'Ya existe una caja en la fecha ${AppUtils.formatDate(existingSameDateOther.registerDate)}.',
      );
    }

    // Update only the registerDate
    final companion = CashRegistersCompanion(registerDate: Value(dateOnly));

    final updated = await (update(
      cashRegisters,
    )..where((tbl) => tbl.id.equals(cashRegisterId))).writeReturning(companion);

    if (updated.isEmpty) {
      return CashRegisterResult.failure(
        CashRegisterError.notFound,
        cashRegister: null,
        message: 'No se actualizó ninguna caja.',
      );
    }

    return CashRegisterResult.success(updated[0]);
  }

  Future<CashRegister?> getLastCashRegisterByStatus(CashRegisterStatus status) {
    final query = (select(cashRegisters)
      ..where((tbl) => tbl.status.equals(status.name))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.registerDate, mode: OrderingMode.desc),
      ])
      ..limit(1));

    return query.getSingleOrNull();
  }

  Future<double> getTotalSalesByCashRegisterId(int cashRegisterId) async {
    final totalSalesExp = db.sales.totalPrice.sum();

    final query =
        await (selectOnly(db.sales)
              ..addColumns([totalSalesExp])
              ..where(
                db.sales.cashRegisterId.equals(cashRegisterId) &
                    db.sales.status.equals(AppActiveStatus.active.name),
              ))
            .getSingle();

    return query.read(totalSalesExp) ?? 0.0;
  }

  Future<double> getTotalPurchasesByCashRegisterId(int cashRegisterId) async {
    final totalPurchasesExp = db.purchases.totalCost.sum();

    final query =
        await (selectOnly(db.purchases)
              ..addColumns([totalPurchasesExp])
              ..where(
                db.purchases.cashRegisterId.equals(cashRegisterId) &
                    db.purchases.status.equals(AppActiveStatus.active.name),
              ))
            .getSingle();

    return query.read(totalPurchasesExp) ?? 0.0;
  }

  Future<double> getTotalExpensesByCashRegisterId(int cashRegisterId) async {
    final totalExpensesExp = db.expenses.amount.sum();

    final query =
        await (selectOnly(db.expenses)
              ..addColumns([totalExpensesExp])
              ..where(
                db.expenses.cashRegisterId.equals(cashRegisterId) &
                    db.expenses.status.equals(AppActiveStatus.active.name),
              ))
            .getSingle();

    return query.read(totalExpensesExp) ?? 0.0;
  }

  Future<double> getTotalIncomesByCashRegisterId(int cashRegisterId) async {
    final totalIncomesExp = db.incomes.amount.sum();

    final query =
        await (selectOnly(db.incomes)
              ..addColumns([totalIncomesExp])
              ..where(
                db.incomes.cashRegisterId.equals(cashRegisterId) &
                    db.incomes.status.equals(AppActiveStatus.active.name),
              ))
            .getSingle();

    return query.read(totalIncomesExp) ?? 0.0;
  }

  Future<double> getAvailableBalanceByCashRegisterId(int cashRegisterId) async {
    final cashRegister = await (select(
      cashRegisters,
    )..where((tbl) => tbl.id.equals(cashRegisterId))).getSingle();

    final totalSales = await getTotalSalesByCashRegisterId(cashRegisterId);
    final totalPurchases = await getTotalPurchasesByCashRegisterId(
      cashRegisterId,
    );
    final totalExpenses = await getTotalExpensesByCashRegisterId(
      cashRegisterId,
    );
    final totalIncomes = await getTotalIncomesByCashRegisterId(cashRegisterId);

    // available balance
    return cashRegister.openingAmount +
        totalSales +
        totalIncomes -
        totalPurchases -
        totalExpenses;
  }

  Future<void> closeCashRegister({required int cashRegisterId}) async {
    final closingAmount = await getAvailableBalanceByCashRegisterId(
      cashRegisterId,
    );
    final totalSales = await getTotalSalesByCashRegisterId(cashRegisterId);
    await (update(
      cashRegisters,
    )..where((t) => t.id.equals(cashRegisterId))).write(
      CashRegistersCompanion(
        closingAmount: Value(closingAmount),
        status: Value(CashRegisterStatus.closed),
        totalSales: Value(totalSales),
      ),
    );
  }

  Future<bool> isLastCreated(CashRegister cashRegister) async {
    final lastRegister =
        await (select(cashRegisters)
              ..orderBy([(t) => OrderingTerm.desc(t.registerDate)])
              ..limit(1))
            .getSingleOrNull();

    if (lastRegister == null) return false;
    return lastRegister.id == cashRegister.id;
  }
}
