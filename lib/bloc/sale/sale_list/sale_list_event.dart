part of 'sale_list_bloc.dart';

sealed class SaleListEvent extends Equatable {
  const SaleListEvent();

  @override
  List<Object> get props => [];
}

// Event to load sales
class LoadSalesListEvent extends SaleListEvent {
  final AppEventSource eventSource;

  const LoadSalesListEvent(this.eventSource);

  @override
  List<Object> get props => [eventSource];
}
