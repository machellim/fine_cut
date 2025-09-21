part of 'inventory_adjustment_crud_bloc.dart';

sealed class InventoryAdjustmentCrudEvent extends Equatable {
  const InventoryAdjustmentCrudEvent();

  @override
  List<Object> get props => [];
}

// create or update inventory adjustment
class CreateInventoryAdjustmentCrudEvent extends InventoryAdjustmentCrudEvent {
  final RecordAction recordAction;
  final InventoryAdjustmentsCompanion inventoryAdjustmentCompanion;

  const CreateInventoryAdjustmentCrudEvent(
    this.recordAction,
    this.inventoryAdjustmentCompanion,
  );

  @override
  List<Object> get props => [recordAction, inventoryAdjustmentCompanion];
}

// delete inventory adjustment (soft delete)
class DeleteInventoryAdjustmentEvent extends InventoryAdjustmentCrudEvent {
  final int inventoryAdjustmentId;

  const DeleteInventoryAdjustmentEvent(this.inventoryAdjustmentId);

  @override
  List<Object> get props => [inventoryAdjustmentId];
}
