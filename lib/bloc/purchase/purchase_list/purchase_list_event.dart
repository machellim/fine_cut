part of 'purchase_list_bloc.dart';

sealed class PurchaseListEvent extends Equatable {
  const PurchaseListEvent();

  @override
  List<Object> get props => [];
}

// Event to load purchases
class LoadPurchasesListEvent extends PurchaseListEvent {
  final AppEventSource eventSource;
  final int cashRegisterId;

  const LoadPurchasesListEvent(this.eventSource, this.cashRegisterId);

  @override
  List<Object> get props => [eventSource, cashRegisterId];
}
