part of 'available_balance_bloc.dart';

sealed class AvailableBalanceState extends Equatable {
  const AvailableBalanceState();

  @override
  List<Object> get props => [];
}

final class AvailableBalanceInitial extends AvailableBalanceState {}

// load list of purchases
class AvailableBalanceLoading extends AvailableBalanceState {}

class AvailableBalanceLoadSuccess extends AvailableBalanceState {
  final double availableBalance;

  const AvailableBalanceLoadSuccess(this.availableBalance);
}

class AvailableBalanceLoadFailure extends AvailableBalanceState {
  final String message;

  const AvailableBalanceLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
