part of 'cash_register_data_bloc.dart';

sealed class CashRegisterState extends Equatable {
  const CashRegisterState();

  @override
  List<Object> get props => [];
}

final class CashRegisterInitial extends CashRegisterState {}

// === states to load initial data ===
class DataCashRegisterLoading extends CashRegisterState {}

class DataCashRegisterLoadSuccess extends CashRegisterState {
  final double lastClosingAmount;

  const DataCashRegisterLoadSuccess(this.lastClosingAmount);
}

class DataCashRegisterLoadFailure extends CashRegisterState {
  final String message;

  const DataCashRegisterLoadFailure({required this.message});
}
