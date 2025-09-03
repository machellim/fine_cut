part of 'purchase_crud_bloc.dart';

sealed class PurchaseCrudEvent extends Equatable {
  const PurchaseCrudEvent();

  @override
  List<Object> get props => [];
}

// create or update purchase
class CreatePurchaseEvent extends PurchaseCrudEvent {
  final RecordAction recordAction;
  final PurchasesCompanion purchaseCompanion;
  final Product selectedProduct;

  const CreatePurchaseEvent(
    this.recordAction,
    this.purchaseCompanion,
    this.selectedProduct,
  );

  @override
  List<Object> get props => [recordAction, purchaseCompanion, selectedProduct];
}

// delete purchase (soft delete)
class DeletePurchaseEvent extends PurchaseCrudEvent {
  final int purchaseId;

  const DeletePurchaseEvent(this.purchaseId);

  @override
  List<Object> get props => [purchaseId];
}
