import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/purchase_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'parent_product_purchases_list_event.dart';
part 'parent_product_purchases_list_state.dart';

class ParentProductPurchasesListBloc
    extends
        Bloc<ParentProductPurchasesListEvent, ParentProductPurchasesListState> {
  final PurchaseDao purchaseDao;
  ParentProductPurchasesListBloc({required this.purchaseDao})
    : super(ParentProductPurchasesListInitial()) {
    on<LoadParentProductPurchasesEvent>((event, emit) async {
      try {
        emit(ParentProductPurchasesListLoading());
        //await Future.delayed(Duration(seconds: 3));
        final purchases = await purchaseDao.getPurchasesWithSubproducts();
        emit(ParentProductPurchasesListSuccess(purchases));
      } catch (e) {
        emit(
          ParentProductPurchasesListFailure(
            message: 'Error al cargar las ventas.',
          ),
        );
      }
    });
  }
}
