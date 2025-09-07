part of 'parent_product_purchases_list_bloc.dart';

sealed class ParentProductPurchasesListState extends Equatable {
  const ParentProductPurchasesListState();

  @override
  List<Object> get props => [];
}

final class ParentProductPurchasesListInitial
    extends ParentProductPurchasesListState {}

// load list of purchases
class ParentProductPurchasesListLoading
    extends ParentProductPurchasesListState {}

class ParentProductPurchasesListSuccess
    extends ParentProductPurchasesListState {
  final List<Purchase> purchases;

  const ParentProductPurchasesListSuccess(this.purchases);
}

class ParentProductPurchasesListFailure
    extends ParentProductPurchasesListState {
  final String message;

  const ParentProductPurchasesListFailure({required this.message});

  @override
  List<Object> get props => [message];
}
