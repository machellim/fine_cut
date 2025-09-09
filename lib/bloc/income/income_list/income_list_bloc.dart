import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/income_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'income_list_event.dart';
part 'income_list_state.dart';

class IncomeListBloc extends Bloc<IncomeListEvent, IncomeListState> {
  final IncomeDao incomeDao;
  IncomeListBloc({required this.incomeDao}) : super(IncomeListInitial()) {
    on<LoadIncomesListEvent>((event, emit) async {
      try {
        emit(IncomesListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final expenses = await incomeDao.getIncomesByCashRegisterId(
          event.cashRegisterId,
        );
        emit(IncomesListLoadSuccess(expenses, event.eventSource));
      } catch (e) {
        emit(IncomesListLoadFailure(message: 'Error al cargar los ingresos.'));
      }
    });
  }
}
