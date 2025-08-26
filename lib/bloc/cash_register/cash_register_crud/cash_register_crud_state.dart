part of 'cash_register_crud_bloc.dart';

sealed class CashRegisterCrudState extends Equatable {
  const CashRegisterCrudState();

  @override
  List<Object> get props => [];
}

final class CashRegisterCrudInitial extends CashRegisterCrudState {}

// === states to create cash register ===
class CreateCashRegisterLoading extends CashRegisterCrudState {}

class CreateCashRegisterSuccess extends CashRegisterCrudState {
  final CashRegister cashRegister;

  const CreateCashRegisterSuccess(this.cashRegister);
}

class CreateCashRegisterFailure extends CashRegisterCrudState {
  final String message;

  const CreateCashRegisterFailure({required this.message});
}
