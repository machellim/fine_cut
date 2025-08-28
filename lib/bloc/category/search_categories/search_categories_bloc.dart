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
    on<SearchCategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FilterCategoriesEvent>((event, emit) async {
      try {
        emit(FilterCategoriesLoading());
        final query = event.query;
        if (query.trim().length < 3) {
          emit(FilterCategoriesSuccess([]));
        } else {
          final results = await categoryDao.searchCategories(event.query);
          emit(FilterCategoriesSuccess(results));
        }
      } catch (e) {
        emit(
          FilterCategoriesFailure(message: 'Error al filtrar las categorías.'),
        );
      }
    });
  }
}
