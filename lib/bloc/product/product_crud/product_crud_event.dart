part of 'product_crud_bloc.dart';

sealed class ProductCrudEvent extends Equatable {
  const ProductCrudEvent();

  @override
  List<Object> get props => [];
}

// event to reset state
class ResetProductCrudEvent extends ProductCrudEvent {}

// create or update category
class CreateProductCrudEvent extends ProductCrudEvent {
  final RecordAction recordAction;
  final ProductsCompanion product;
  final List<ProductSubproductsCompanion> subproducts;

  const CreateProductCrudEvent(
    this.recordAction,
    this.product,
    this.subproducts,
  );

  @override
  List<Object> get props => [recordAction, product];
}
