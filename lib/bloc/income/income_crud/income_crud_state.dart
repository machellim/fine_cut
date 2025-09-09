part of 'income_crud_bloc.dart';

sealed class IncomeCrudState extends Equatable {
  const IncomeCrudState();

  @override
  List<Object> get props => [];
}

final class IncomeCrudInitial extends IncomeCrudState {}

// create income
class IncomeCreationInProgress extends IncomeCrudState {}

class IncomeCreationSuccess extends IncomeCrudState {
  final int incomeId;

  const IncomeCreationSuccess(this.incomeId);
}

class IncomeCreationFailure extends IncomeCrudState {
  final String message;

  const IncomeCreationFailure({required this.message});
}

// update Income
class IncomeUpdateSuccess extends IncomeCrudState {
  final String message;

  const IncomeUpdateSuccess({required this.message});
}

class IncomeUpdateFailure extends IncomeCrudState {
  final String message;

  const IncomeUpdateFailure({required this.message});
}

// delete income
class IncomeDeletionInProgress extends IncomeCrudState {}

class IncomeDeletionSuccess extends IncomeCrudState {
  final String message;

  const IncomeDeletionSuccess({required this.message});
}

class IncomeDeletionFailure extends IncomeCrudState {
  final String message;

  const IncomeDeletionFailure({required this.message});
}
