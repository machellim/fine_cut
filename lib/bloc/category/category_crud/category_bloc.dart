import 'package:fine_cut/db/dao/category_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_event.dart';
import 'package:fine_cut/bloc/category/category_crud/category_state.dart';
import 'package:fine_cut/db/database.dart';
import 'package:drift/drift.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryDao categoryDao;

  CategoryBloc({required this.categoryDao}) : super(CategoriesInitial()) {
    on<ResetCategoryEvent>((event, emit) {
      emit(CategoriesInitial());
    });
    // Registro del evento CreateCategoryEvent
    on<CreateCategoryEvent>((event, emit) async {
      try {
        emit(CategoryCreationInProgress());

        if (event.action == 'create') {
          final category = await categoryDao.createCategory(
            name: event.category.name.value,
            description: event.category.description.value,
          );
          if (category == null) {
            emit(
              CategoryCreationFailure(
                message:
                    'La Categoría con nombre "${event.category.name.value}" ya fue creada.',
              ),
            );
          } else {
            emit(CategoryCreationSuccess(category));
          }
        } else if (event.action == 'update') {
          final category = await categoryDao.updateCategory(
            id: event.category.id.value,
            name: event.category.name.value,
            description: event.category.description.value,
            status: event.category.status.value,
          );
          if (category == null) {
            emit(
              CategoryUpdateFailure(
                message:
                    'La Categoría con nombre "${event.category.name.value}" ya fue creada.',
              ),
            );
          } else {
            emit(
              CategoryUpdateSuccess(
                message: 'Categoría actualizada correctamente',
              ),
            );
          }
        }
      } catch (e) {
        print(e);
        emit(CategoryCreationFailure(message: 'Error al crear la categoría'));
      }
    });
  }
}
