part of 'product_profit_list_bloc.dart';

sealed class ProductProfitListEvent extends Equatable {
  const ProductProfitListEvent();

  @override
  List<Object> get props => [];
}

// Event to load product profit list
class LoadProductProfitListEvent extends ProductProfitListEvent {
  final String startDate;
  final String endDate;

  const LoadProductProfitListEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}
