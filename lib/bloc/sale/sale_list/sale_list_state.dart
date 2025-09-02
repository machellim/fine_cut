part of 'sale_list_bloc.dart';

sealed class SaleListState extends Equatable {
  const SaleListState();
  
  @override
  List<Object> get props => [];
}

final class SaleListInitial extends SaleListState {}
