import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/expense_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  final ExpenseDao expenseDao;
  ExpenseListBloc({required this.expenseDao}) : super(ExpenseListInitial()) {
    on<LoadExpensesListEvent>((event, emit) async {
      try {
        emit(ExpensesListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final purchases = await expenseDao.getExpensesByCashRegisterId(
          event.cashRegisterId,
        );
        emit(ExpensesListLoadSuccess(purchases, event.eventSource));
      } catch (e) {
        emit(ExpensesListLoadFailure(message: 'Error al cargar las compras.'));
      }
    });
  }
}
