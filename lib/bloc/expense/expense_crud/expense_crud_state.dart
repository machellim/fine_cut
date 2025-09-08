part of 'expense_crud_bloc.dart';

sealed class ExpenseCrudState extends Equatable {
  const ExpenseCrudState();

  @override
  List<Object> get props => [];
}

final class ExpenseCrudInitial extends ExpenseCrudState {}

// create expense
class ExpenseCreationInProgress extends ExpenseCrudState {}

class ExpenseCreationSuccess extends ExpenseCrudState {
  final int expenseId;

  const ExpenseCreationSuccess(this.expenseId);
}

class ExpenseCreationFailure extends ExpenseCrudState {
  final String message;

  const ExpenseCreationFailure({required this.message});
}

// update Expense
class ExpenseUpdateSuccess extends ExpenseCrudState {
  final String message;

  const ExpenseUpdateSuccess({required this.message});
}

class ExpenseUpdateFailure extends ExpenseCrudState {
  final String message;

  const ExpenseUpdateFailure({required this.message});
}

// delete expense
class ExpenseDeletionInProgress extends ExpenseCrudState {}

class ExpenseDeletionSuccess extends ExpenseCrudState {
  final String message;

  const ExpenseDeletionSuccess({required this.message});
}

class ExpenseDeletionFailure extends ExpenseCrudState {
  final String message;

  const ExpenseDeletionFailure({required this.message});
}
