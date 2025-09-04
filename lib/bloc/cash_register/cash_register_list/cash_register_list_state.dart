part of 'cash_register_list_bloc.dart';

sealed class CashRegisterListState extends Equatable {
  const CashRegisterListState();

  @override
  List<Object> get props => [];
}

final class CashRegisterListInitial extends CashRegisterListState {}

// load list of categories
class CashRegisterListLoading extends CashRegisterListState {}

class CashRegisterListLoadSuccess extends CashRegisterListState {
  final List<CashRegister> cashRegisters;
  final AppEventSource eventSource;

  const CashRegisterListLoadSuccess(this.cashRegisters, this.eventSource);
}

class CashRegisterListLoadFailure extends CashRegisterListState {
  final String message;

  const CashRegisterListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
