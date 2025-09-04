import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'cash_register_list_event.dart';
part 'cash_register_list_state.dart';

class CashRegisterListBloc
    extends Bloc<CashRegisterListEvent, CashRegisterListState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterListBloc({required this.cashRegisterDao})
    : super(CashRegisterListInitial()) {
    on<CashRegisterListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadCashRegisterListEvent>((event, emit) async {
      try {
        emit(CashRegisterListLoading());
        //await Future.delayed(Duration(seconds: 3));
        final categories = await cashRegisterDao.getAllCashRegisters();
        emit(CashRegisterListLoadSuccess(categories, event.eventSource));
      } catch (e) {
        emit(
          CashRegisterListLoadFailure(message: 'Error al cargar las cajas.'),
        );
      }
    });
  }
}
