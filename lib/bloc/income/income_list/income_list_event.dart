part of 'income_list_bloc.dart';

sealed class IncomeListEvent extends Equatable {
  const IncomeListEvent();

  @override
  List<Object> get props => [];
}

// Event to load incomes
class LoadIncomesListEvent extends IncomeListEvent {
  final AppEventSource eventSource;
  final int cashRegisterId;

  const LoadIncomesListEvent(this.eventSource, this.cashRegisterId);

  @override
  List<Object> get props => [eventSource, cashRegisterId];
}
