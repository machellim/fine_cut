import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/product_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  final ProductDao productDao;
  ProductsListBloc({required this.productDao}) : super(ProductListInitial()) {
    on<ProductsListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadProductsListEvent>((event, emit) async {
      try {
        emit(ProductsListLoading());
        // await Future.delayed(Duration(seconds: 3));
        final products = await productDao.getAllProducts();
        emit(ProductsListLoadSuccess(products, event.eventSource));
      } catch (e) {
        emit(
          ProductsListLoadFailure(message: 'Error al cargar las productos.'),
        );
      }
    });
  }
}
