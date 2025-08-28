part of 'search_categories_bloc.dart';

sealed class SearchCategoriesState extends Equatable {
  const SearchCategoriesState();

  @override
  List<Object> get props => [];
}

final class SearchCategoriesInitial extends SearchCategoriesState {}

// filter categories by query
class FilterCategoriesLoading extends SearchCategoriesState {}

class FilterCategoriesSuccess extends SearchCategoriesState {
  final List<Category> categories;

  const FilterCategoriesSuccess(this.categories);
}

class FilterCategoriesFailure extends SearchCategoriesState {
  final String message;

  const FilterCategoriesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
