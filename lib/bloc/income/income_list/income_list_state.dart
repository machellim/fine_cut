part of 'income_list_bloc.dart';

sealed class IncomeListState extends Equatable {
  const IncomeListState();

  @override
  List<Object> get props => [];
}

final class IncomeListInitial extends IncomeListState {}

// load list of incomes
class IncomesListLoading extends IncomeListState {}

class IncomesListLoadSuccess extends IncomeListState {
  final List<Income> incomes;
  final AppEventSource eventSource;

  const IncomesListLoadSuccess(this.incomes, this.eventSource);
}

class IncomesListLoadFailure extends IncomeListState {
  final String message;

  const IncomesListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
