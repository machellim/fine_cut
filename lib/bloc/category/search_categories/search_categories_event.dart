part of 'search_categories_bloc.dart';

sealed class SearchCategoriesEvent extends Equatable {
  const SearchCategoriesEvent();

  @override
  List<Object> get props => [];
}

// event to filter categories by query
class FilterCategoriesEvent extends SearchCategoriesEvent {
  final String query;

  const FilterCategoriesEvent(this.query);

  @override
  List<Object> get props => [query];
}
