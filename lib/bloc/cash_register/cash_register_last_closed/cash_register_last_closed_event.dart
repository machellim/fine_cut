part of 'cash_register_last_closed_bloc.dart';

sealed class CashRegisterLastClosedEvent extends Equatable {
  const CashRegisterLastClosedEvent();

  @override
  List<Object> get props => [];
}

// Event to get cash register last closed
class GetCashRegisterLastClosedEvent extends CashRegisterLastClosedEvent {
  final CashRegisterStatus status;

  const GetCashRegisterLastClosedEvent(this.status);

  @override
  List<Object> get props => [status];
}
