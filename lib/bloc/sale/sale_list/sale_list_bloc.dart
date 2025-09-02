import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sale_list_event.dart';
part 'sale_list_state.dart';

class SaleListBloc extends Bloc<SaleListEvent, SaleListState> {
  SaleListBloc() : super(SaleListInitial()) {
    on<SaleListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
