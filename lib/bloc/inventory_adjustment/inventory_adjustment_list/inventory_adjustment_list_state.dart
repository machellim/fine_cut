part of 'inventory_adjustment_list_bloc.dart';

sealed class InventoryAdjustmentListState extends Equatable {
  const InventoryAdjustmentListState();

  @override
  List<Object> get props => [];
}

final class InventoryAdjustmentListInitial
    extends InventoryAdjustmentListState {}

// load list of inventory adjustments
final class InventoryAdjustmentListLoading
    extends InventoryAdjustmentListState {}

final class InventoryAdjustmentListLoadSuccess
    extends InventoryAdjustmentListState {
  final List<InventoryAdjustment> inventoryAdjustments;
  final AppEventSource eventSource;

  const InventoryAdjustmentListLoadSuccess(
    this.inventoryAdjustments,
    this.eventSource,
  );

  @override
  List<Object> get props => [inventoryAdjustments, eventSource];
}

final class InventoryAdjustmentListLoadFailure
    extends InventoryAdjustmentListState {
  final String message;

  const InventoryAdjustmentListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
