part of 'sale_parent_product_bloc.dart';

sealed class SaleParentProductState extends Equatable {
  const SaleParentProductState();

  @override
  List<Object> get props => [];
}

final class SaleParentProductInitial extends SaleParentProductState {}

// get parent products
class GetParentProductLoading extends SaleParentProductState {}

class GetParentProductSuccess extends SaleParentProductState {
  final List<Purchase> parentProducts;
  final int subproductId;

  const GetParentProductSuccess(this.parentProducts, this.subproductId);
}

class GetParentProductFailure extends SaleParentProductState {
  final String message;

  const GetParentProductFailure({required this.message});

  @override
  List<Object> get props => [message];
}
