part of 'cash_register_list_bloc.dart';

sealed class CashRegisterListState extends Equatable {
  const CashRegisterListState();

  @override
  List<Object> get props => [];
}

final class CashRegisterListInitial extends CashRegisterListState {}
