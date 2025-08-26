part of 'cash_register_data_bloc.dart';

sealed class CashRegisterEvent extends Equatable {
  const CashRegisterEvent();

  @override
  List<Object> get props => [];
}

// === Event to load initial data ===
class LoadDataCashRegisterEvent extends CashRegisterEvent {}
