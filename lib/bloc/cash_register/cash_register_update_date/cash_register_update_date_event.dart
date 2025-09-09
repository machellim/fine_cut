part of 'cash_register_update_date_bloc.dart';

sealed class CashRegisterUpdateDateEvent extends Equatable {
  const CashRegisterUpdateDateEvent();

  @override
  List<Object> get props => [];
}

// event to reset state
class ResetUpdateCashRegisterDateEvent extends CashRegisterUpdateDateEvent {}

// Event to update cash register date
class UpdateCashRegisterDateEvent extends CashRegisterUpdateDateEvent {
  final int cashRegisterId;
  final String registerDate;

  const UpdateCashRegisterDateEvent(this.cashRegisterId, this.registerDate);

  @override
  List<Object> get props => [cashRegisterId, registerDate];
}
