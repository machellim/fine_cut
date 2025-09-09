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
    on<ResetGetParentProductEvent>((event, emit) {
      emit(SaleParentProductInitial());
    });

    on<GetParentProductEvent>((event, emit) async {
      try {
        emit(GetParentProductLoading());
        final subproduct = event.product;
        final purchases = await saleDao.getPurchasesBySubproductId(
          subproduct.id,
        );
        // check if productId is subproduct
        final bool isSubproduct = await saleDao.existsAsSubproduct(
          subproduct.id,
        );
        if (isSubproduct) {
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
