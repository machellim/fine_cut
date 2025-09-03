part of 'cash_register_close_bloc.dart';

sealed class CashRegisterCloseEvent extends Equatable {
  const CashRegisterCloseEvent();

  @override
  List<Object> get props => [];
}

// Event to close cash register
class CloseCashRegisterEvent extends CashRegisterCloseEvent {
  final int cashRegisterId;

  const CloseCashRegisterEvent(this.cashRegisterId);

  @override
  List<Object> get props => [cashRegisterId];
}
