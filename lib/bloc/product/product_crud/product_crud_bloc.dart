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

        if (event.recordAction == RecordAction.create) {
          final product = await productDao.createProduct(
            categoryId: event.product.categoryId.value,
            name: event.product.name.value,
            hasSubProducts: event.product.hasSubProducts.value,
            description: event.product.description.value,
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
            id: event.product.id.value,
            categoryId: event.product.categoryId.value,
            name: event.product.name.value,
            hasSubProducts: event.product.hasSubProducts.value,
            description: event.product.description.value,
            status: event.product.status.value,
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
      } catch (e) {
        print(e);
        emit(ProductCrudCreationFailure(message: 'Error al crear producto.'));
      }
    });
  }
}
