import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/category_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'categories_list_event.dart';
part 'categories_list_state.dart';

class CategoriesListBloc
    extends Bloc<CategoriesListEvent, CategoriesListState> {
  final CategoryDao categoryDao;

  CategoriesListBloc({required this.categoryDao})
    : super(CategoriesListInitial()) {
    on<CategoriesListEvent>((event, emit) {
      // TODO: implement event handler
    });

    // list categories
    on<LoadCategoriesListEvent>((event, emit) async {
      try {
        // Emite un estado de "carga en progreso"
        emit(CategoriesListLoading());
        //await Future.delayed(Duration(seconds: 3));
        final categories = await categoryDao.getAllCategories();
        emit(CategoriesListLoadSuccess(categories, event.eventSource));
      } catch (e) {
        emit(
          CategoriesListLoadFailure(message: 'Error al cargar las categorías'),
        );
      }
    });
  }
}
