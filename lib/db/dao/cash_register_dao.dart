import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart';
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
    return (select(
      cashRegisters,
    )..orderBy([(t) => OrderingTerm.desc(t.registerDate)])).get();
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

  Future<CashRegister?> createCashRegister({
    required String registerDateString,
    required double openingAmount,
    String? notes,
  }) async {
    // Parse date
    final dateFormat = DateFormat("dd-MM-yyyy");
    final parsedDate = dateFormat.parse(registerDateString);

    // Truncar hora para guardar solo la fecha
    final dateOnly = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    final existing = await (select(
      cashRegisters,
    )..where((tbl) => tbl.registerDate.equals(dateOnly))).getSingleOrNull();

    if (existing != null) {
      return null;
    }

    final companion = CashRegistersCompanion.insert(
      registerDate: Value(dateOnly),
      openingAmount: Value(openingAmount),
      status: Value(CashRegisterStatus.open),
      notes: Value(notes),
    );

    return await into(cashRegisters).insertReturning(companion);
  }
}
