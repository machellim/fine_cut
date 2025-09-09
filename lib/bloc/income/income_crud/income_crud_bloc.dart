import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/income_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'income_crud_event.dart';
part 'income_crud_state.dart';

class IncomeCrudBloc extends Bloc<IncomeCrudEvent, IncomeCrudState> {
  final IncomeDao incomeDao;
  IncomeCrudBloc({required this.incomeDao}) : super(IncomeCrudInitial()) {
    on<CreateIncomeCrudEvent>((event, emit) async {
      try {
        emit(IncomeCreationInProgress());
        final expenseId = await incomeDao.createOrUpdateIncome(
          event.incomeCompanion,
          event.recordAction,
        );

        if (expenseId < 0) {
          if (event.recordAction == RecordAction.create) {
            emit(IncomeCreationFailure(message: 'La compra no fue creada.'));
          } else {
            emit(IncomeUpdateFailure(message: 'La compra no fue actualizada.'));
          }
        } else {
          // Éxito
          if (event.recordAction == RecordAction.create) {
            emit(IncomeCreationSuccess(expenseId));
          } else {
            emit(
              IncomeUpdateSuccess(message: 'Compra actualizada correctamente.'),
            );
          }
        }
      } catch (e) {
        emit(
          IncomeCreationFailure(message: 'Exception: Error al crear gasto.'),
        );
      }
    });

    on<DeleteIncomeEvent>((event, emit) async {
      try {
        emit(IncomeDeletionInProgress());
        final rowsUpdated = await incomeDao.softDeleteIncomee(event.incomeId);
        //final rowsUpdated = 0;
        if (rowsUpdated > 0) {
          emit(
            IncomeDeletionSuccess(message: 'Ingreso eliminado correctamente.'),
          );
        } else {
          emit(IncomeDeletionFailure(message: 'No se encontró el ingreso.'));
        }
      } catch (e) {
        emit(IncomeDeletionFailure(message: 'Error al eliminar ingreso.'));
      }
    });
  }
}
