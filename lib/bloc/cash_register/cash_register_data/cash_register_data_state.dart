part of 'cash_register_data_bloc.dart';

sealed class CashRegisterDataState extends Equatable {
  const CashRegisterDataState();

  @override
  List<Object> get props => [];
}

final class CashRegisterInitial extends CashRegisterDataState {}

// === states to load initial data ===
class DataCashRegisterLoading extends CashRegisterDataState {}

class DataCashRegisterLoadSuccess extends CashRegisterDataState {
  final double lastClosingAmount;
  final DateTime nextRegisterDate;

  const DataCashRegisterLoadSuccess({
    required this.lastClosingAmount,
    required this.nextRegisterDate,
  });
}

class DataCashRegisterLoadFailure extends CashRegisterDataState {
  final String message;

  const DataCashRegisterLoadFailure({required this.message});
}
