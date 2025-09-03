import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/sale_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'sale_crud_event.dart';
part 'sale_crud_state.dart';

class SaleCrudBloc extends Bloc<SaleCrudEvent, SaleCrudState> {
  final SaleDao saleDao;
  SaleCrudBloc({required this.saleDao}) : super(SaleCrudInitial()) {
    on<SaleCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
