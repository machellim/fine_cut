import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'cash_register_can_edit_event.dart';
part 'cash_register_can_edit_state.dart';

class CashRegisterCanEditBloc
    extends Bloc<CashRegisterCanEditEvent, CashRegisterCanEditState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterCanEditBloc({required this.cashRegisterDao})
    : super(CashRegisterCanEditInitial()) {
    on<CashRegisterCanEditEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CashRegisterEditCheckEvent>((event, emit) async {
      try {
        emit(CashRegisterEditCheckLoading());
        await Future.delayed(Duration(seconds: 1));
        final isEditable = await cashRegisterDao.isLastCreated(
          event.cashRegister,
        );
        if (isEditable) {
          emit(
            CashRegisterEditCheckLoadSuccess(cashRegister: event.cashRegister),
          );
        } else {
          emit(
            CashRegisterEditCheckLoadFailure(
              message: 'Esta caja no se puede editar.',
            ),
          );
        }
      } catch (e) {
        emit(
          CashRegisterEditCheckLoadFailure(
            message: 'Error al intentar editar.',
          ),
        );
      }
    });

    on<ResetCashRegisterCanEditEvent>((event, emit) {
      emit(CashRegisterCanEditInitial());
    });
  }
}
