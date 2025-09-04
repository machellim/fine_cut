part of 'cash_register_can_edit_bloc.dart';

sealed class CashRegisterCanEditState extends Equatable {
  const CashRegisterCanEditState();

  @override
  List<Object> get props => [];
}

final class CashRegisterCanEditInitial extends CashRegisterCanEditState {}

// check can edit
class CashRegisterEditCheckLoading extends CashRegisterCanEditState {}

class CashRegisterEditCheckLoadSuccess extends CashRegisterCanEditState {
  final CashRegister cashRegister;

  const CashRegisterEditCheckLoadSuccess({required this.cashRegister});
}

class CashRegisterEditCheckLoadFailure extends CashRegisterCanEditState {
  final String message;

  const CashRegisterEditCheckLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
