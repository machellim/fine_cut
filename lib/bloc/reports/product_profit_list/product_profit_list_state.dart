part of 'product_profit_list_bloc.dart';

sealed class ProductProfitListState extends Equatable {
  const ProductProfitListState();

  @override
  List<Object> get props => [];
}

final class ProductProfitListInitial extends ProductProfitListState {}

// load list of purchases
class ProductProfitListLoading extends ProductProfitListState {}

class ProductProfitListSuccess extends ProductProfitListState {
  final List<ProductProfit> productProfitList;

  const ProductProfitListSuccess(this.productProfitList);
}

class ProductProfitListFailure extends ProductProfitListState {
  final String message;

  const ProductProfitListFailure({required this.message});

  @override
  List<Object> get props => [message];
}
