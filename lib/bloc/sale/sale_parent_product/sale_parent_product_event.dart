part of 'sale_parent_product_bloc.dart';

sealed class SaleParentProductEvent extends Equatable {
  const SaleParentProductEvent();

  @override
  List<Object> get props => [];
}

// Event to get parent product
class GetParentProductEvent extends SaleParentProductEvent {
  final Product product;

  const GetParentProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
