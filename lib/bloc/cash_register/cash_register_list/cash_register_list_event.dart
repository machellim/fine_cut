part of 'cash_register_list_bloc.dart';

sealed class CashRegisterListEvent extends Equatable {
  const CashRegisterListEvent();

  @override
  List<Object> get props => [];
}

// reset

// Event to load cash registers
class LoadCashRegisterListEvent extends CashRegisterListEvent {
  final AppEventSource eventSource;

  const LoadCashRegisterListEvent(this.eventSource);

  @override
  List<Object> get props => [eventSource];
}
