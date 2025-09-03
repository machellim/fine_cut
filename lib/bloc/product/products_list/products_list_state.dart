part of 'products_list_bloc.dart';

sealed class ProductsListState extends Equatable {
  const ProductsListState();

  @override
  List<Object> get props => [];
}

final class ProductListInitial extends ProductsListState {}

// load list of products
class ProductsListLoading extends ProductsListState {}

class ProductsListLoadSuccess extends ProductsListState {
  final List<Product> products;
  final AppEventSource eventSource;

  const ProductsListLoadSuccess(this.products, this.eventSource);
}

class ProductsListLoadFailure extends ProductsListState {
  final String message;

  const ProductsListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
