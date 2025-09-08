part of 'expense_list_bloc.dart';

sealed class ExpenseListEvent extends Equatable {
  const ExpenseListEvent();

  @override
  List<Object> get props => [];
}

// Event to load expenses
class LoadExpensesListEvent extends ExpenseListEvent {
  final AppEventSource eventSource;
  final int cashRegisterId;

  const LoadExpensesListEvent(this.eventSource, this.cashRegisterId);

  @override
  List<Object> get props => [eventSource, cashRegisterId];
}
