import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/product_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'product_crud_event.dart';
part 'product_crud_state.dart';

class ProductCrudBloc extends Bloc<ProductCrudEvent, ProductCrudState> {
  final ProductDao productDao;
  ProductCrudBloc({required this.productDao}) : super(ProductCrudInitial()) {
    on<ResetProductCrudEvent>((event, emit) {
      emit(ProductCrudInitial());
    });

    on<CreateProductCrudEvent>((event, emit) async {
      try {
        emit(ProductCrudCreationInProgress());
        //await Future.delayed(Duration(seconds: 2));
        if (event.recordAction == RecordAction.create) {
          final product = await productDao.createProduct(
            productCompanion: event.product,
            subproducts: event.subproducts,
          );
          if (product == null) {
            emit(
              ProductCrudCreationFailure(
                message:
                    'El Producto con nombre "${event.product.name.value}" ya existe.',
              ),
            );
          } else {
            emit(ProductCrudCreationSuccess(product));
          }
        } else if (event.recordAction == RecordAction.update) {
          final product = await productDao.updateProduct(
            productCompanion: event.product,
            subproducts: event.subproducts,
          );
          if (product == null) {
            emit(
              ProductCrudUpdateFailure(
                message:
                    'El producto con nombre "${event.product.name.value}" ya existe.',
              ),
            );
          } else {
            emit(
              ProductCrudUpdateSuccess(
                message: 'Producto actualizado correctamente',
              ),
            );
          }
        }
      } catch (e, t) {
        print(e);
        emit(ProductCrudCreationFailure(message: 'Error al crear producto.'));
      }
    });
  }
}
