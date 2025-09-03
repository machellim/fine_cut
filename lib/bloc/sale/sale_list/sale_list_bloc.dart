import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/sale_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'sale_list_event.dart';
part 'sale_list_state.dart';

class SaleListBloc extends Bloc<SaleListEvent, SaleListState> {
  final SaleDao saleDao;
  SaleListBloc({required this.saleDao}) : super(SaleListInitial()) {
    on<SaleListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadSalesListEvent>((event, emit) async {
      try {
        emit(SaleListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final purchases = await saleDao.getAllSales();
        emit(SaleListLoadSuccess(purchases, event.eventSource));
      } catch (e) {
        emit(SaleListLoadFailure(message: 'Error al cargar las compras.'));
      }
    });
  }
}
