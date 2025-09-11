import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/purchase_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'purchase_crud_event.dart';
part 'purchase_crud_state.dart';

class PurchaseCrudBloc extends Bloc<PurchaseCrudEvent, PurchaseCrudState> {
  final PurchaseDao purchaseDao;
  PurchaseCrudBloc({required this.purchaseDao}) : super(PurchaseCrudInitial()) {
    on<PurchaseCrudEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreatePurchaseEvent>((event, emit) async {
      try {
        emit(PurchaseCreationInProgress());

        final purchaseId = await purchaseDao.createOrUpdatePurchase(
          event.purchaseCompanion,
          event.recordAction,
          event.selectedProduct,
        );

        if (purchaseId < 0) {
          if (event.recordAction == RecordAction.create) {
            emit(PurchaseCreationFailure(message: 'La compra no fue creada.'));
          } else {
            emit(
              PurchaseUpdateFailure(message: 'La compra no fue actualizada.'),
            );
          }
        } else {
          // Éxito
          if (event.recordAction == RecordAction.create) {
            emit(PurchaseCreationSuccess(purchaseId));
          } else {
            emit(
              PurchaseUpdateSuccess(
                message: 'Compra actualizada correctamente.',
              ),
            );
          }
        }
      } catch (e, stackTrace) {
        emit(
          PurchaseCreationFailure(message: 'Exception: Error al crear compra'),
        );
      }
    });

    on<DeletePurchaseEvent>((event, emit) async {
      try {
        emit(PurchaseDeletionInProgress());
        final rowsUpdated = await purchaseDao.softDeletePurchaseIfNoSales(
          event.purchaseId,
        );
        //final rowsUpdated = 0;
        if (rowsUpdated > 0) {
          emit(
            PurchaseDeletionSuccess(message: 'Compra eliminada correctamente.'),
          );
        } else {
          emit(
            PurchaseDeletionFailure(
              message:
                  'No se puede eliminar la compra porque tiene ventas asociadas.',
            ),
          );
        }
      } catch (e) {
        emit(PurchaseDeletionFailure(message: 'Error al eliminar compra.'));
      }
    });
  }
}
