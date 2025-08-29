part of 'search_categories_bloc.dart';

sealed class SearchCategoriesEvent extends Equatable {
  const SearchCategoriesEvent();

  @override
  List<Object> get props => [];
}

// event to filter categories by query
class FilterCategoriesEvent extends SearchCategoriesEvent {
  final String filter;

  const FilterCategoriesEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
