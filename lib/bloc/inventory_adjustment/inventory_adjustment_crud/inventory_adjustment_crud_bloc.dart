import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/inventory_adjustment_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'inventory_adjustment_crud_event.dart';
part 'inventory_adjustment_crud_state.dart';

class InventoryAdjustmentCrudBloc
    extends Bloc<InventoryAdjustmentCrudEvent, InventoryAdjustmentCrudState> {
  final InventoryAdjustmentDao inventoryAdjustmentDao;
  InventoryAdjustmentCrudBloc({required this.inventoryAdjustmentDao})
    : super(InventoryAdjustmentCrudInitial()) {
    on<CreateInventoryAdjustmentCrudEvent>((event, emit) async {
      try {
        emit(InventoryAdjustmentCreationInProgress());
        final inventoryAdjustmentId = await inventoryAdjustmentDao
            .createOrUpdateInventoryAdjustment(
              event.inventoryAdjustmentCompanion,
              event.recordAction,
            );
        if (inventoryAdjustmentId < 0) {
          if (event.recordAction == RecordAction.create) {
            emit(
              InventoryAdjustmentCreationFailure(
                message: 'El ajuste no fue creado.',
              ),
            );
          } else {
            emit(
              InventoryAdjustmentUpdateFailure(
                message: 'El ajuste no fue actualizado.',
              ),
            );
          }
        } else {
          if (event.recordAction == RecordAction.create) {
            emit(InventoryAdjustmentCreationSuccess(inventoryAdjustmentId));
          } else {
            emit(
              InventoryAdjustmentUpdateSuccess(
                message: 'Ajuste actualizado correctamente.',
              ),
            );
          }
        }
      } catch (e) {
        print(e);
        emit(
          InventoryAdjustmentCreationFailure(
            message: 'Error al crear el ajuste',
          ),
        );
      }
    });

    on<DeleteInventoryAdjustmentEvent>((event, emit) async {
      try {
        emit(InventoryAdjustmentDeletionInProgress());
        final rowsUpdated = await inventoryAdjustmentDao
            .softDeleteInventoryAdjustment(event.inventoryAdjustmentId);
        //final rowsUpdated = 0;
        if (rowsUpdated > 0) {
          emit(
            InventoryAdjustmentDeletionSuccess(
              message: 'Ajuste eliminado correctamente.',
            ),
          );
        } else {
          emit(
            InventoryAdjustmentDeletionFailure(
              message: 'No se encontró el ajuste.',
            ),
          );
        }
      } catch (e) {
        emit(
          InventoryAdjustmentDeletionFailure(
            message: 'Error al eliminar ajuste.',
          ),
        );
      }
    });
  }
}
