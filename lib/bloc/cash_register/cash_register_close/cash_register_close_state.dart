part of 'cash_register_close_bloc.dart';

sealed class CashRegisterCloseState extends Equatable {
  const CashRegisterCloseState();

  @override
  List<Object> get props => [];
}

final class CashRegisterCloseInitial extends CashRegisterCloseState {}

// close cash register
class CloseCashRegisterLoading extends CashRegisterCloseState {}

class CloseCashRegisterSuccess extends CashRegisterCloseState {
  const CloseCashRegisterSuccess();
}

class CloseCashRegisterFailure extends CashRegisterCloseState {
  final String message;

  const CloseCashRegisterFailure({required this.message});

  @override
  List<Object> get props => [message];
}
