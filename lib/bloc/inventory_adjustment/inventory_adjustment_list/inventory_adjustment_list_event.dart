part of 'inventory_adjustment_list_bloc.dart';

sealed class InventoryAdjustmentListEvent extends Equatable {
  const InventoryAdjustmentListEvent();

  @override
  List<Object> get props => [];
}

// Event to load inventory adjustments
class LoadInventoryAdjustmentListEvent extends InventoryAdjustmentListEvent {
  final AppEventSource eventSource;
  final int cashRegisterId;

  const LoadInventoryAdjustmentListEvent(this.eventSource, this.cashRegisterId);

  @override
  List<Object> get props => [eventSource, cashRegisterId];
}
