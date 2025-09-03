part of 'sale_list_bloc.dart';

sealed class SaleListEvent extends Equatable {
  const SaleListEvent();

  @override
  List<Object> get props => [];
}

// Event to load sales
class LoadSalesListEvent extends SaleListEvent {
  final AppEventSource eventSource;
  final int cashRegisterId;

  const LoadSalesListEvent(this.eventSource, this.cashRegisterId);

  @override
  List<Object> get props => [eventSource, cashRegisterId];
}
