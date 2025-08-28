part of 'products_list_bloc.dart';

sealed class ProductsListEvent extends Equatable {
  const ProductsListEvent();

  @override
  List<Object> get props => [];
}

// Event to load products
class LoadProductsListEvent extends ProductsListEvent {
  final AppEventSource eventSource;

  const LoadProductsListEvent(this.eventSource);

  @override
  List<Object> get props => [eventSource];
}
