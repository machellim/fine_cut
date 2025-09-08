import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/expense_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'expense_crud_event.dart';
part 'expense_crud_state.dart';

class ExpenseCrudBloc extends Bloc<ExpenseCrudEvent, ExpenseCrudState> {
  final ExpenseDao expenseDao;
  ExpenseCrudBloc({required this.expenseDao}) : super(ExpenseCrudInitial()) {
    on<CreateExpenseCrudEvent>((event, emit) async {
      try {
        emit(ExpenseCreationInProgress());
        final expenseId = await expenseDao.createOrUpdateExpense(
          event.expenseCompanion,
          event.recordAction,
        );

        if (expenseId < 0) {
          if (event.recordAction == RecordAction.create) {
            emit(ExpenseCreationFailure(message: 'La compra no fue creada.'));
          } else {
            emit(
              ExpenseCreationFailure(message: 'La compra no fue actualizada.'),
            );
          }
        } else {
          // Éxito
          if (event.recordAction == RecordAction.create) {
            emit(ExpenseCreationSuccess(expenseId));
          } else {
            emit(
              ExpenseUpdateSuccess(
                message: 'Compra actualizada correctamente.',
              ),
            );
          }
        }
      } catch (e) {
        emit(
          ExpenseCreationFailure(message: 'Exception: Error al crear gasto.'),
        );
      }
    });

    on<DeleteExpenseEvent>((event, emit) async {
      try {
        emit(ExpenseDeletionInProgress());
        final rowsUpdated = await expenseDao.softDeleteExpense(event.expenseId);
        //final rowsUpdated = 0;
        if (rowsUpdated > 0) {
          emit(
            ExpenseDeletionSuccess(message: 'Gasto eliminado correctamente.'),
          );
        } else {
          emit(ExpenseDeletionFailure(message: 'No se encontró el gasto.'));
        }
      } catch (e) {
        emit(ExpenseDeletionFailure(message: 'Error al eliminar gasto.'));
      }
    });
  }
}
