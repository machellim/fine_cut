part of 'parent_product_sales_list_bloc.dart';

sealed class ParentProductSalesListEvent extends Equatable {
  const ParentProductSalesListEvent();

  @override
  List<Object> get props => [];
}

// Event to load sales
class ParentProductSalesEvent extends ParentProductSalesListEvent {
  final int purchaseId;

  const ParentProductSalesEvent(this.purchaseId);

  @override
  List<Object> get props => [];
}
