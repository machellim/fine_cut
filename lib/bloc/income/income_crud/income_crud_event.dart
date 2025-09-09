part of 'income_crud_bloc.dart';

sealed class IncomeCrudEvent extends Equatable {
  const IncomeCrudEvent();

  @override
  List<Object> get props => [];
}

// create or update expense
class CreateIncomeCrudEvent extends IncomeCrudEvent {
  final RecordAction recordAction;
  final IncomesCompanion incomeCompanion;

  const CreateIncomeCrudEvent(this.recordAction, this.incomeCompanion);

  @override
  List<Object> get props => [recordAction, incomeCompanion];
}

// delete expense (soft delete)
class DeleteIncomeEvent extends IncomeCrudEvent {
  final int incomeId;

  const DeleteIncomeEvent(this.incomeId);

  @override
  List<Object> get props => [incomeId];
}
