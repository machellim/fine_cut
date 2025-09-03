import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/sale_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'sale_crud_event.dart';
part 'sale_crud_state.dart';

class SaleCrudBloc extends Bloc<SaleCrudEvent, SaleCrudState> {
  final SaleDao saleDao;
  SaleCrudBloc({required this.saleDao}) : super(SaleCrudInitial()) {
    on<SaleCrudEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateSaleEvent>((event, emit) async {
      try {
        emit(SaleCreationInProgress());

        final purchaseId = await saleDao.createOrUpdateSale(
          event.saleCompanion,
          event.recordAction,
          event.selectedProduct,
        );

        if (purchaseId < 0) {
          if (event.recordAction == RecordAction.create) {
            emit(SaleCreationFailure(message: 'La venta no fue creada.'));
          } else {
            emit(SaleUpdateFailure(message: 'La venta no fue actualizada.'));
          }
        } else {
          // Éxito
          if (event.recordAction == RecordAction.create) {
            emit(SaleCreationSuccess(purchaseId));
          } else {
            emit(
              SaleUpdateSuccess(message: 'Venta actualizada correctamente.'),
            );
          }
        }
      } catch (e) {
        print(e);
        emit(SaleCreationFailure(message: 'Exception: Error al crear venta'));
      }
    });

    on<DeleteSaleEvent>((event, emit) async {
      try {
        emit(SaleDeletionInProgress());
        final rowsUpdated = await saleDao.softDeleteSale(event.saleId);
        //final rowsUpdated = 0;
        if (rowsUpdated > 0) {
          emit(SaleDeletionSuccess(message: 'Venta eliminada correctamente.'));
        } else {
          emit(SaleDeletionFailure(message: 'No se encontró la venta.'));
        }
      } catch (e) {
        emit(SaleDeletionFailure(message: 'Error al eliminar venta.'));
      }
    });
  }
}
