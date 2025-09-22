import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/inventory_adjustment_dao.dart';

part 'inventory_adjustment_list_event.dart';
part 'inventory_adjustment_list_state.dart';

class InventoryAdjustmentListBloc
    extends Bloc<InventoryAdjustmentListEvent, InventoryAdjustmentListState> {
  final InventoryAdjustmentDao inventoryAdjustmentDao;
  InventoryAdjustmentListBloc({required this.inventoryAdjustmentDao})
    : super(InventoryAdjustmentListInitial()) {
    on<LoadInventoryAdjustmentListEvent>((event, emit) async {
      try {
        emit(InventoryAdjustmentListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final inventoryAdjustments = await inventoryAdjustmentDao
            .getInventoryAdjustmentsWithDetails(event.cashRegisterId);
        emit(
          InventoryAdjustmentListLoadSuccess(
            inventoryAdjustments,
            event.eventSource,
          ),
        );
      } catch (e) {
        emit(
          InventoryAdjustmentListLoadFailure(
            message: 'Error al cargar las compras.',
          ),
        );
      }
    });
  }
}
