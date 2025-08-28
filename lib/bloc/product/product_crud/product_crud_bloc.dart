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
    on<ProductCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
