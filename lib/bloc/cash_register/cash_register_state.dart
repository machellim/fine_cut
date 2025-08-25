part of 'cash_register_bloc.dart';

sealed class CashRegisterState extends Equatable {
  const CashRegisterState();
  
  @override
  List<Object> get props => [];
}

final class CashRegisterInitial extends CashRegisterState {}
