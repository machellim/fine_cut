import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cash_register_event.dart';
part 'cash_register_state.dart';

class CashRegisterBloc extends Bloc<CashRegisterEvent, CashRegisterState> {
  CashRegisterBloc() : super(CashRegisterInitial()) {
    on<CashRegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
