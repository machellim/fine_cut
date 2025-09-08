part of 'expense_crud_bloc.dart';

sealed class ExpenseCrudEvent extends Equatable {
  const ExpenseCrudEvent();

  @override
  List<Object> get props => [];
}

// event to reset state
class ResetExpenseEvent extends ExpenseCrudEvent {}

// create or update expense
class CreateExpenseCrudEvent extends ExpenseCrudEvent {
  final RecordAction recordAction;
  final ExpensesCompanion expenseCompanion;

  const CreateExpenseCrudEvent(this.recordAction, this.expenseCompanion);

  @override
  List<Object> get props => [recordAction, expenseCompanion];
}

// delete expense (soft delete)
class DeleteExpenseEvent extends ExpenseCrudEvent {
  final int expenseId;

  const DeleteExpenseEvent(this.expenseId);

  @override
  List<Object> get props => [expenseId];
}
