part of 'cash_register_data_bloc.dart';

sealed class CashRegisterDataEvent extends Equatable {
  const CashRegisterDataEvent();

  @override
  List<Object> get props => [];
}

// === Event to load initial data ===
class LoadDataCashRegisterEvent extends CashRegisterDataEvent {}
