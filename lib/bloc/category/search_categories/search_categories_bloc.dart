import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/category_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'search_categories_event.dart';
part 'search_categories_state.dart';

class SearchCategoriesBloc
    extends Bloc<SearchCategoriesEvent, SearchCategoriesState> {
  final CategoryDao categoryDao;
  SearchCategoriesBloc({required this.categoryDao})
    : super(SearchCategoriesInitial()) {
    on<FilterCategoriesEvent>((event, emit) async {
      try {
        emit(FilterCategoriesLoading());
        final categories = await categoryDao.searchCategories(event.filter);
        emit(FilterCategoriesSuccess(categories));
      } catch (e) {
        emit(
          FilterCategoriesFailure(message: 'Error al filtrar las categorías.'),
        );
      }
    });
  }
}
