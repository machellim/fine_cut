import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'cash_register_data_event.dart';
part 'cash_register_data_state.dart';

class CashRegisterBloc extends Bloc<CashRegisterEvent, CashRegisterState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterBloc({required this.cashRegisterDao})
    : super(CashRegisterInitial()) {
    on<CashRegisterEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadDataCashRegisterEvent>((event, emit) async {
      emit(DataCashRegisterLoading());
      //await Future.delayed(Duration(seconds: 3));
      try {
        final lastClosingAmount = await cashRegisterDao.getLastClosingAmount();
        emit(DataCashRegisterLoadSuccess(lastClosingAmount));
      } catch (e) {
        emit(DataCashRegisterLoadFailure(message: e.toString()));
      }
    });
  }
}
