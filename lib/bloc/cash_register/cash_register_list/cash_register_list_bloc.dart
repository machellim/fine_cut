import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cash_register_list_event.dart';
part 'cash_register_list_state.dart';

class CashRegisterListBloc
    extends Bloc<CashRegisterListEvent, CashRegisterListState> {
  CashRegisterListBloc() : super(CashRegisterListInitial()) {
    on<CashRegisterListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
