import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/cash_register_dao.dart';

part 'available_balance_event.dart';
part 'available_balance_state.dart';

class AvailableBalanceBloc
    extends Bloc<AvailableBalanceEvent, AvailableBalanceState> {
  final CashRegisterDao cashRegisterDao;
  AvailableBalanceBloc({required this.cashRegisterDao})
    : super(AvailableBalanceInitial()) {
    on<AvailableBalanceEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadAvailableBalanceEvent>((event, emit) async {
      try {
        emit(AvailableBalanceLoading());
        //await Future.delayed(Duration(seconds: 1));
        final availableBalance = await cashRegisterDao
            .getAvailableBalanceByCashRegisterId(event.cashRegisterId);
        emit(AvailableBalanceLoadSuccess(availableBalance));
      } catch (e) {
        emit(
          AvailableBalanceLoadFailure(message: 'Error al cargar las compras.'),
        );
      }
    });
  }
}
