import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
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

  Future<CashRegisterResult> createCashRegister({
    required String registerDateString,
    required double openingAmount,
    String? notes,
  }) async {
    // Parsear la fecha
    final dateFormat = DateFormat("dd-MM-yyyy");
    final parsedDate = dateFormat.parse(registerDateString);

    // Truncar hora para guardar solo la fecha
    final dateOnly = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    // 1️⃣ Check if there is an open cash register
    final openRegister =
        await (select(cashRegisters)
              ..where((tbl) => tbl.status.equals(CashRegisterStatus.open.name)))
            .getSingleOrNull();

    if (openRegister != null) {
      return CashRegisterResult.failure(
        CashRegisterError.alreadyOpen,
        openRegister,
      );
    }

    // 2️⃣ Check if a cash register already exists for the specified date
    final existing = await (select(
      cashRegisters,
    )..where((tbl) => tbl.registerDate.equals(dateOnly))).getSingleOrNull();

    if (existing != null) {
      // Retornar error con la caja existente
      return CashRegisterResult.failure(CashRegisterError.sameDate, existing);
    }

    // 3️⃣ Create new cash register
    final companion = CashRegistersCompanion.insert(
      registerDate: Value(dateOnly),
      openingAmount: Value(openingAmount),
      status: Value(CashRegisterStatus.open),
      notes: Value(notes),
    );

    final newRegister = await into(cashRegisters).insertReturning(companion);

    return CashRegisterResult.success(newRegister);
  }

  Future<CashRegister?> getLastOpenCashRegister() {
    final query = (select(cashRegisters)
      ..where((tbl) => tbl.status.equals(CashRegisterStatus.open.name))
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

  Future<double> getAvailableBalanceByCashRegisterId(int cashRegisterId) async {
    final cashRegister = await (select(
      cashRegisters,
    )..where((tbl) => tbl.id.equals(cashRegisterId))).getSingle();

    final totalSales = await getTotalSalesByCashRegisterId(cashRegisterId);
    final totalPurchases = await getTotalPurchasesByCashRegisterId(
      cashRegisterId,
    );
    // available balance
    return cashRegister.openingAmount + totalSales - totalPurchases;
  }

  Future<void> closeCashRegister({required int cashRegisterId}) async {
    final closingAmount = await getAvailableBalanceByCashRegisterId(
      cashRegisterId,
    );
    await (update(
      cashRegisters,
    )..where((t) => t.id.equals(cashRegisterId))).write(
      CashRegistersCompanion(
        closingAmount: Value(closingAmount),
        status: Value(CashRegisterStatus.closed),
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
