import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/models/cash_register_result.dart';

part 'cash_register_crud_event.dart';
part 'cash_register_crud_state.dart';

class CashRegisterCrudBloc
    extends Bloc<CashRegisterCrudEvent, CashRegisterCrudState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterCrudBloc({required this.cashRegisterDao})
    : super(CashRegisterCrudInitial()) {
    on<CreateCashRegisterEvent>((event, emit) async {
      emit(CreateCashRegisterLoading());
      //await Future.delayed(Duration(seconds: 3));
      try {
        final cashRegisterResult = await cashRegisterDao.createCashRegister(
          registerDateString: event.registerDate,
          openingAmount: event.openingAmount,
          notes: event.notes,
        );
        if (!cashRegisterResult.isSuccess) {
          final cashRegister = cashRegisterResult.cashRegister!;

          if (cashRegisterResult.error == CashRegisterError.alreadyOpen) {
            emit(
              CreateCashRegisterFailure(
                message:
                    'Existe una caja abierta en la fecha ${AppUtils.formatDate(cashRegister.registerDate)}, para poder crear una nueva primero debe cerrarse.',
              ),
            );
          } else if (cashRegisterResult.error == CashRegisterError.sameDate) {
            emit(
              CreateCashRegisterFailure(
                message:
                    'La Caja de la fecha ${AppUtils.formatDate(cashRegister.registerDate)} ya fue creada.',
              ),
            );
          } else if (cashRegisterResult.error ==
              CashRegisterError.earlierThanLast) {
            emit(
              CreateCashRegisterFailure(
                message:
                    'Solo se puede crear cajas mayores a esta fecha ${AppUtils.formatDate(cashRegister.registerDate)}.',
              ),
            );
          }
        } else {
          emit(CreateCashRegisterSuccess(cashRegisterResult));
        }
        //emit(CreateCashRegisterSuccess(null));
      } catch (e) {
        emit(CreateCashRegisterFailure(message: e.toString()));
      }
    });
  }
}
