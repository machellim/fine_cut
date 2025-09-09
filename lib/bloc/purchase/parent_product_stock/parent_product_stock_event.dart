part of 'parent_product_stock_bloc.dart';

sealed class ParentProductStockEvent extends Equatable {
  const ParentProductStockEvent();

  @override
  List<Object> get props => [];
}

// Event to load parent products
class LoadParentProductStockListEvent extends ParentProductStockEvent {}

// Event to updade parent products isSoldOut
class UpdateParentProductIsSoldOutListEvent extends ParentProductStockEvent {
  final int purchaseId;
  final bool isSoldOut;

  const UpdateParentProductIsSoldOutListEvent(this.purchaseId, this.isSoldOut);

  @override
  List<Object> get props => [purchaseId, isSoldOut];
}
