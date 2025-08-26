import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'cash_register_crud_event.dart';
part 'cash_register_crud_state.dart';

class CashRegisterCrudBloc
    extends Bloc<CashRegisterCrudEvent, CashRegisterCrudState> {
  final CashRegisterDao cashRegisterDao;
  CashRegisterCrudBloc({required this.cashRegisterDao})
    : super(CashRegisterCrudInitial()) {
    on<CashRegisterCrudEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateCashRegisterEvent>((event, emit) async {
      emit(CreateCashRegisterLoading());
      //await Future.delayed(Duration(seconds: 3));
      try {
        final cashRegister = await cashRegisterDao.createCashRegister(
          registerDateString: event.registerDate,
          openingAmount: event.openingAmount,
          notes: event.notes,
        );
        emit(CreateCashRegisterSuccess(cashRegister));
      } catch (e) {
        emit(CreateCashRegisterFailure(message: e.toString()));
      }
    });
  }
}
