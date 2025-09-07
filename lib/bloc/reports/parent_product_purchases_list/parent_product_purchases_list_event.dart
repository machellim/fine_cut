part of 'parent_product_purchases_list_bloc.dart';

sealed class ParentProductPurchasesListEvent extends Equatable {
  const ParentProductPurchasesListEvent();

  @override
  List<Object> get props => [];
}

// Event to load purchases
class LoadParentProductPurchasesEvent extends ParentProductPurchasesListEvent {
  const LoadParentProductPurchasesEvent();

  @override
  List<Object> get props => [];
}
