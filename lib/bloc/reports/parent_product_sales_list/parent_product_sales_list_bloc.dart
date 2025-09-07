import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/sale_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'parent_product_sales_list_event.dart';
part 'parent_product_sales_list_state.dart';

class ParentProductSalesListBloc
    extends Bloc<ParentProductSalesListEvent, ParentProductSalesListState> {
  final SaleDao saleDao;
  ParentProductSalesListBloc({required this.saleDao})
    : super(ParentProductSalesListInitial()) {
    on<ParentProductSalesListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ParentProductSalesEvent>((event, emit) async {
      try {
        emit(ParentProductSalesListLoading());
        //await Future.delayed(Duration(seconds: 1));
        final purchaseId = event.purchaseId;
        final sales = await saleDao.getSalesByPurchaseId(purchaseId);
        emit(ParentProductSalesListSuccess(sales));
      } catch (e) {
        emit(
          ParentProductSalesListFailure(message: 'Error al cargar las ventas.'),
        );
      }
    });
  }
}
