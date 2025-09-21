import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/sale_dao.dart';
import 'package:fine_cut/models/product_profit.dart';

part 'product_profit_list_event.dart';
part 'product_profit_list_state.dart';

class ProductProfitListBloc
    extends Bloc<ProductProfitListEvent, ProductProfitListState> {
  final SaleDao saleDao;
  ProductProfitListBloc({required this.saleDao})
    : super(ProductProfitListInitial()) {
    on<LoadProductProfitListEvent>((event, emit) async {
      try {
        emit(ProductProfitListLoading());
        // await Future.delayed(Duration(seconds: 2));
        final startDate = event.startDate;
        final endDate = event.endDate;

        final productProfitList = await saleDao.getProfitByProduct(
          startDate,
          endDate,
        );
        emit(ProductProfitListSuccess(productProfitList));
      } catch (e) {
        emit(ProductProfitListFailure(message: e.toString()));
      }
    });
  }
}
