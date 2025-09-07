part of 'parent_product_sales_list_bloc.dart';

sealed class ParentProductSalesListState extends Equatable {
  const ParentProductSalesListState();

  @override
  List<Object> get props => [];
}

final class ParentProductSalesListInitial extends ParentProductSalesListState {}

// load list of sales
class ParentProductSalesListLoading extends ParentProductSalesListState {}

class ParentProductSalesListSuccess extends ParentProductSalesListState {
  final List<Sale> sales;

  const ParentProductSalesListSuccess(this.sales);
}

class ParentProductSalesListFailure extends ParentProductSalesListState {
  final String message;

  const ParentProductSalesListFailure({required this.message});

  @override
  List<Object> get props => [message];
}
