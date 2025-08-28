part of 'categories_list_bloc.dart';

sealed class CategoriesListState extends Equatable {
  const CategoriesListState();

  @override
  List<Object> get props => [];
}

final class CategoriesListInitial extends CategoriesListState {}

// load list of categories
class CategoriesListLoading extends CategoriesListState {}

class CategoriesListLoadSuccess extends CategoriesListState {
  final List<Category> categories;
  final AppEventSource eventSource;

  const CategoriesListLoadSuccess(this.categories, this.eventSource);
}

class CategoriesListLoadFailure extends CategoriesListState {
  final String message;

  const CategoriesListLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
