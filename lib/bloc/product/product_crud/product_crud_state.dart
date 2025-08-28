part of 'product_crud_bloc.dart';

sealed class ProductCrudState extends Equatable {
  const ProductCrudState();

  @override
  List<Object> get props => [];
}

final class ProductCrudInitial extends ProductCrudState {}

// create category
class ProductCrudCreationInProgress extends ProductCrudState {}

class ProductCrudCreationSuccess extends ProductCrudState {
  final Product? product;

  const ProductCrudCreationSuccess(this.product);
}

class ProductCrudCreationFailure extends ProductCrudState {
  final String message;

  const ProductCrudCreationFailure({required this.message});
}

// update category
class ProductCrudUpdateSuccess extends ProductCrudState {
  final String message;

  const ProductCrudUpdateSuccess({required this.message});
}

class ProductCrudUpdateFailure extends ProductCrudState {
  final String message;

  const ProductCrudUpdateFailure({required this.message});
}
