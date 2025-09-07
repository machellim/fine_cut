import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'cash_register_last_closed_event.dart';
part 'cash_register_last_closed_state.dart';

class CashRegisterLastClosedBloc
    extends Bloc<CashRegisterLastClosedEvent, CashRegisterLastClosedState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterLastClosedBloc({required this.cashRegisterDao})
    : super(CashRegisterLastClosedInitial()) {
    on<GetCashRegisterLastClosedEvent>((event, emit) async {
      try {
        emit(GetCashRegisterLastClosedLoading());
        //await Future.delayed(Duration(seconds: 1));
        final cashRegister = await cashRegisterDao.getLastCashRegisterByStatus(
          CashRegisterStatus.closed,
        );
        if (cashRegister != null) {
          emit(GetCashRegisterLastClosedLoadSuccess(cashRegister));
        } else {
          emit(
            GetCashRegisterLastClosedLoadFailure(
              message: 'No se encontró información de la última caja.',
            ),
          );
        }
      } catch (e) {
        emit(
          GetCashRegisterLastClosedLoadFailure(
            message:
                'Error al cargar la información de la última caja cerrada.',
          ),
        );
      }
    });
  }
}
