part of 'available_balance_bloc.dart';

sealed class AvailableBalanceEvent extends Equatable {
  const AvailableBalanceEvent();

  @override
  List<Object> get props => [];
}

// Event to get available balance
class LoadAvailableBalanceEvent extends AvailableBalanceEvent {
  final int cashRegisterId;

  const LoadAvailableBalanceEvent(this.cashRegisterId);

  @override
  List<Object> get props => [cashRegisterId];
}
