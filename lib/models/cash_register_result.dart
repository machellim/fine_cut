import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';

class CashRegisterResult {
  final CashRegister? cashRegister;
  final CashRegisterError? error;
  final String? message; // Optional message for success or error

  // Success constructor
  CashRegisterResult.success(this.cashRegister, {this.message}) : error = null;

  // Failure constructor
  CashRegisterResult.failure(this.error, {this.cashRegister, this.message});

  // Indicates if the operation was successful
  bool get isSuccess => error == null;

  // Returns a user-friendly message
  String get displayMessage {
    if (isSuccess) {
      return message ?? 'Operation completed successfully';
    } else {
      return message ?? 'An unexpected error occurred';
    }
  }
}
