part of 'sale_list_bloc.dart';

sealed class SaleListState extends Equatable {
  const SaleListState();

  @override
  List<Object> get props => [];
}

final class SaleListInitial extends SaleListState {}

// load list of sales
class SaleListLoading extends SaleListState {}

class SaleListLoadSuccess extends SaleListState {
  final List<Sale> sales;
  final AppEventSource eventSource;

  const SaleListLoadSuccess(this.sales, this.eventSource);
}

class SaleListLoadFailure extends SaleListState {
  final String message;

  const SaleListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
