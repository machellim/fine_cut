part of 'purchase_list_bloc.dart';

sealed class PurchaseListEvent extends Equatable {
  const PurchaseListEvent();

  @override
  List<Object> get props => [];
}

// Event to load purchases
class LoadPurchasesListEvent extends PurchaseListEvent {
  final AppEventSource eventSource;

  const LoadPurchasesListEvent(this.eventSource);

  @override
  List<Object> get props => [eventSource];
}
