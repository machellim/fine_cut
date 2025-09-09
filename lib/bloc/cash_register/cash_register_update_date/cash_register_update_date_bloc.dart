import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'cash_register_update_date_event.dart';
part 'cash_register_update_date_state.dart';

class CashRegisterUpdateDateBloc
    extends Bloc<CashRegisterUpdateDateEvent, CashRegisterUpdateDateState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterUpdateDateBloc({required this.cashRegisterDao})
    : super(CashRegisterUpdateDateInitial()) {
    on<ResetUpdateCashRegisterDateEvent>((event, emit) {
      emit(CashRegisterUpdateDateInitial());
    });

    on<UpdateCashRegisterDateEvent>((event, emit) async {
      try {
        emit(UpdateCashRegisterDateLoading());
        await Future.delayed(Duration(seconds: 1));
        final cashRegisterResult = await cashRegisterDao
            .createOrUpdateCashRegister(
              cashRegisterId: event.cashRegisterId,
              registerDateString: event.registerDate,
              action: RecordAction.update,
            );
        if (cashRegisterResult.isSuccess) {
          emit(
            UpdateCashRegisterDateLoadSuccess(cashRegisterResult.cashRegister!),
          );
        } else {
          emit(
            UpdateCashRegisterDateLoadFailure(
              message: cashRegisterResult.message!,
            ),
          );
        }
      } catch (e) {
        emit(
          UpdateCashRegisterDateLoadFailure(message: 'Error al actualizar.'),
        );
      }
    });
  }
}
