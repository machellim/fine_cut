import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/purchase_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'purchase_list_event.dart';
part 'purchase_list_state.dart';

class PurchaseListBloc extends Bloc<PurchaseListEvent, PurchaseListState> {
  final PurchaseDao purchaseDao;
  PurchaseListBloc({required this.purchaseDao}) : super(PurchaseListInitial()) {
    on<PurchaseListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadPurchasesListEvent>((event, emit) async {
      try {
        emit(PurchaseListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final purchases = await purchaseDao.getAllPurchases();
        emit(PurchaseListLoadSuccess(purchases, event.eventSource));
      } catch (e) {
        emit(PurchaseListLoadFailure(message: 'Error al cargar las compras.'));
      }
    });
  }
}
