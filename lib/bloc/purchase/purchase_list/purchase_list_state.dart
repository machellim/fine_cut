part of 'purchase_list_bloc.dart';

sealed class PurchaseListState extends Equatable {
  const PurchaseListState();

  @override
  List<Object> get props => [];
}

final class PurchaseListInitial extends PurchaseListState {}

// load list of purchases
class PurchaseListLoading extends PurchaseListState {}

class PurchaseListLoadSuccess extends PurchaseListState {
  final List<Purchase> purchases;
  final AppEventSource eventSource;

  const PurchaseListLoadSuccess(this.purchases, this.eventSource);
}

class PurchaseListLoadFailure extends PurchaseListState {
  final String message;

  const PurchaseListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
