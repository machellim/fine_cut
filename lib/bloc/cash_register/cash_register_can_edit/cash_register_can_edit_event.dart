part of 'cash_register_can_edit_bloc.dart';

sealed class CashRegisterCanEditEvent extends Equatable {
  const CashRegisterCanEditEvent();

  @override
  List<Object> get props => [];
}

// event to reset state
class ResetCashRegisterCanEditEvent extends CashRegisterCanEditEvent {}

// Event to get available balance
class CashRegisterEditCheckEvent extends CashRegisterCanEditEvent {
  final CashRegister cashRegister;

  const CashRegisterEditCheckEvent(this.cashRegister);

  @override
  List<Object> get props => [cashRegister];
}
