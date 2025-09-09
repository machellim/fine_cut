part of 'cash_register_update_date_bloc.dart';

sealed class CashRegisterUpdateDateState extends Equatable {
  const CashRegisterUpdateDateState();

  @override
  List<Object> get props => [];
}

final class CashRegisterUpdateDateInitial extends CashRegisterUpdateDateState {}

// update cash register date
class UpdateCashRegisterDateLoading extends CashRegisterUpdateDateState {}

class UpdateCashRegisterDateLoadSuccess extends CashRegisterUpdateDateState {
  final DateTime registerDate;

  const UpdateCashRegisterDateLoadSuccess(this.registerDate);
}

class UpdateCashRegisterDateLoadFailure extends CashRegisterUpdateDateState {
  final String message;

  const UpdateCashRegisterDateLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
