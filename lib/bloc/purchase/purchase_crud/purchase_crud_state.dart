part of 'purchase_crud_bloc.dart';

sealed class PurchaseCrudState extends Equatable {
  const PurchaseCrudState();

  @override
  List<Object> get props => [];
}

final class PurchaseCrudInitial extends PurchaseCrudState {}

// create purchase
class PurchaseCreationInProgress extends PurchaseCrudState {}

class PurchaseCreationSuccess extends PurchaseCrudState {
  final int purchaseId;

  const PurchaseCreationSuccess(this.purchaseId);
}

class PurchaseCreationFailure extends PurchaseCrudState {
  final String message;

  const PurchaseCreationFailure({required this.message});
}

// update purchase
class PurchaseUpdateSuccess extends PurchaseCrudState {
  final String message;

  const PurchaseUpdateSuccess({required this.message});
}

class PurchaseUpdateFailure extends PurchaseCrudState {
  final String message;

  const PurchaseUpdateFailure({required this.message});
}

// delete purchase
class PurchaseDeletionInProgress extends PurchaseCrudState {}

class PurchaseDeletionSuccess extends PurchaseCrudState {
  final String message;

  const PurchaseDeletionSuccess({required this.message});
}

class PurchaseDeletionFailure extends PurchaseCrudState {
  final String message;

  const PurchaseDeletionFailure({required this.message});
}
