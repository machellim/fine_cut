import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/sale_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'sale_parent_product_event.dart';
part 'sale_parent_product_state.dart';

class SaleParentProductBloc
    extends Bloc<SaleParentProductEvent, SaleParentProductState> {
  final SaleDao saleDao;
  SaleParentProductBloc({required this.saleDao})
    : super(SaleParentProductInitial()) {
    on<SaleParentProductEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetParentProductEvent>((event, emit) async {
      try {
        emit(GetParentProductLoading());
        final subproduct = event.product;
        final purchases = await saleDao.getPurchasesBySubproductId(
          subproduct.id,
        );
        if (purchases.isNotEmpty) {
          emit(GetParentProductSuccess(purchases, subproduct.id));
        } else {
          emit(SaleParentProductInitial());
        }
      } catch (e) {
        emit(
          GetParentProductFailure(
            message: 'Error al obtener productos padres.',
          ),
        );
      }
    });
  }
}
