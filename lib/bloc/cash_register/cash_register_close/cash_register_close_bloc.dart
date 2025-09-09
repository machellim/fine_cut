import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';

part 'cash_register_close_event.dart';
part 'cash_register_close_state.dart';

class CashRegisterCloseBloc
    extends Bloc<CashRegisterCloseEvent, CashRegisterCloseState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterCloseBloc({required this.cashRegisterDao})
    : super(CashRegisterCloseInitial()) {
    on<CashRegisterCloseEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CloseCashRegisterEvent>((event, emit) async {
      try {
        emit(CloseCashRegisterLoading());
        await Future.delayed(Duration(seconds: 1));
        await cashRegisterDao.closeCashRegister(
          cashRegisterId: event.cashRegisterId,
        );
        emit(CloseCashRegisterSuccess());
        //emit(CloseCashRegisterFailure(message: 'Error al cerrar la caja.'));
      } catch (e) {
        emit(CloseCashRegisterFailure(message: 'Error al cerrar la caja.'));
      }
    });
  }
}
