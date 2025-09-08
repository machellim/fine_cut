part of 'expense_list_bloc.dart';

sealed class ExpenseListState extends Equatable {
  const ExpenseListState();

  @override
  List<Object> get props => [];
}

final class ExpenseListInitial extends ExpenseListState {}

// load list of expenses
class ExpensesListLoading extends ExpenseListState {}

class ExpensesListLoadSuccess extends ExpenseListState {
  final List<Expense> expenses;
  final AppEventSource eventSource;

  const ExpensesListLoadSuccess(this.expenses, this.eventSource);
}

class ExpensesListLoadFailure extends ExpenseListState {
  final String message;

  const ExpensesListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
