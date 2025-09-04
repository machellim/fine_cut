import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';

class CashRegisterResult {
  final CashRegister? cashRegister;
  final CashRegisterError? error;

  CashRegisterResult.success(this.cashRegister) : error = null;

  CashRegisterResult.failure(this.error, this.cashRegister);

  bool get isSuccess => error == null;
}
