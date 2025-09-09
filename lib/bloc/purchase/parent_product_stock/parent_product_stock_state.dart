part of 'parent_product_stock_bloc.dart';

sealed class ParentProductStockState extends Equatable {
  const ParentProductStockState();

  @override
  List<Object> get props => [];
}

final class ParentProductStockInitial extends ParentProductStockState {}

// load list of purchases
class ParentProductStockListLoading extends ParentProductStockState {}

class ParentProductStockListLoadSuccess extends ParentProductStockState {
  final List<Purchase> parentProducts;

  const ParentProductStockListLoadSuccess(this.parentProducts);
}

class ParentProductStockListLoadFailure extends ParentProductStockState {
  final String message;

  const ParentProductStockListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
