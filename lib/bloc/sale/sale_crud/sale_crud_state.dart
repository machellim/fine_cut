part of 'sale_crud_bloc.dart';

sealed class SaleCrudState extends Equatable {
  const SaleCrudState();

  @override
  List<Object> get props => [];
}

final class SaleCrudInitial extends SaleCrudState {}

// create sale
class SaleCreationInProgress extends SaleCrudState {}

class SaleCreationSuccess extends SaleCrudState {
  final int purchaseId;

  const SaleCreationSuccess(this.purchaseId);
}

class SaleCreationFailure extends SaleCrudState {
  final String message;

  const SaleCreationFailure({required this.message});
}

// update sale
class SaleUpdateSuccess extends SaleCrudState {
  final String message;

  const SaleUpdateSuccess({required this.message});
}

class SaleUpdateFailure extends SaleCrudState {
  final String message;

  const SaleUpdateFailure({required this.message});
}
