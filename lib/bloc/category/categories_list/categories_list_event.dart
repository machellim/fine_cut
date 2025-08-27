part of 'categories_list_bloc.dart';

sealed class CategoriesListEvent extends Equatable {
  const CategoriesListEvent();

  @override
  List<Object> get props => [];
}

// Event to load categories
class LoadCategoriesListEvent extends CategoriesListEvent {}
