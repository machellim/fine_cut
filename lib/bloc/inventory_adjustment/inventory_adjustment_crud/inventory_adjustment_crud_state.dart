part of 'inventory_adjustment_crud_bloc.dart';

sealed class InventoryAdjustmentCrudState extends Equatable {
  const InventoryAdjustmentCrudState();

  @override
  List<Object> get props => [];
}

final class InventoryAdjustmentCrudInitial
    extends InventoryAdjustmentCrudState {}

// create inventory adjustment
final class InventoryAdjustmentCreationInProgress
    extends InventoryAdjustmentCrudState {}

final class InventoryAdjustmentCreationSuccess
    extends InventoryAdjustmentCrudState {
  final int inventoryAdjustmentId;

  const InventoryAdjustmentCreationSuccess(this.inventoryAdjustmentId);
}

final class InventoryAdjustmentCreationFailure
    extends InventoryAdjustmentCrudState {
  final String message;

  const InventoryAdjustmentCreationFailure({required this.message});
}

// update inventory adjustment
final class InventoryAdjustmentUpdateSuccess
    extends InventoryAdjustmentCrudState {
  final String message;

  const InventoryAdjustmentUpdateSuccess({required this.message});
}

final class InventoryAdjustmentUpdateFailure
    extends InventoryAdjustmentCrudState {
  final String message;

  const InventoryAdjustmentUpdateFailure({required this.message});
}

// delete inventory adjustment (soft delete)
final class InventoryAdjustmentDeletionInProgress
    extends InventoryAdjustmentCrudState {}

final class InventoryAdjustmentDeletionSuccess
    extends InventoryAdjustmentCrudState {
  final String message;

  const InventoryAdjustmentDeletionSuccess({required this.message});
}

final class InventoryAdjustmentDeletionFailure
    extends InventoryAdjustmentCrudState {
  final String message;

  const InventoryAdjustmentDeletionFailure({required this.message});
}
