import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';

part 'cash_register_data_event.dart';
part 'cash_register_data_state.dart';

class CashRegisterDataBloc
    extends Bloc<CashRegisterDataEvent, CashRegisterDataState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterDataBloc({required this.cashRegisterDao})
    : super(CashRegisterInitial()) {
    on<LoadDataCashRegisterEvent>((event, emit) async {
      emit(DataCashRegisterLoading());
      //await Future.delayed(Duration(seconds: 3));
      try {
        final data = await cashRegisterDao.getDataLastCashRegister();
        emit(
          DataCashRegisterLoadSuccess(
            lastClosingAmount: data['closingAmount'],
            nextRegisterDate: data['nextDate'],
          ),
        );
      } catch (e) {
        emit(DataCashRegisterLoadFailure(message: e.toString()));
      }
    });
  }
}
