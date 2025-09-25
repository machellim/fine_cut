import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/purchase_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'parent_product_stock_event.dart';
part 'parent_product_stock_state.dart';

class ParentProductStockBloc
    extends Bloc<ParentProductStockEvent, ParentProductStockState> {
  final PurchaseDao purchaseDao;
  ParentProductStockBloc({required this.purchaseDao})
    : super(ParentProductStockInitial()) {
    on<LoadParentProductStockListEvent>((event, emit) async {
      try {
        emit(ParentProductStockListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final parentProducts = await purchaseDao.getPurchasesWithSubproducts();
        emit(ParentProductStockListLoadSuccess(parentProducts));
      } catch (e) {
        emit(
          ParentProductStockListLoadFailure(
            message: 'Error al cargar las productos primarios.',
          ),
        );
      }
    });
    on<UpdateParentProductIsSoldOutListEvent>((event, emit) async {
      try {
        emit(ParentProductStockListLoading());
        // await Future.delayed(Duration(seconds: 3));
        await purchaseDao.updateSoldOutStatus(
          event.purchaseId,
          event.isSoldOut,
        );
        final parentProducts = await purchaseDao.getPurchasesWithSubproducts();
        emit(ParentProductStockListLoadSuccess(parentProducts));
      } catch (e) {
        emit(
          ParentProductStockListLoadFailure(
            message: 'Error al cargar las productos primarios.',
          ),
        );
      }
    });
  }
}
