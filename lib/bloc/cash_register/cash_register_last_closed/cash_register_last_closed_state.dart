part of 'cash_register_last_closed_bloc.dart';

sealed class CashRegisterLastClosedState extends Equatable {
  const CashRegisterLastClosedState();

  @override
  List<Object> get props => [];
}

final class CashRegisterLastClosedInitial extends CashRegisterLastClosedState {}

// Get cash register last closed
class GetCashRegisterLastClosedLoading extends CashRegisterLastClosedState {}

class GetCashRegisterLastClosedLoadSuccess extends CashRegisterLastClosedState {
  final CashRegister cashRegister;

  const GetCashRegisterLastClosedLoadSuccess(this.cashRegister);
}

class GetCashRegisterLastClosedLoadFailure extends CashRegisterLastClosedState {
  final String message;

  const GetCashRegisterLastClosedLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
