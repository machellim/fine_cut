import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/database.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoryState {}

// create category
class CategoryCreationInProgress extends CategoryState {}

class CategoryCreationSuccess extends CategoryState {
  final Category? category;

  const CategoryCreationSuccess(this.category);
}

class CategoryCreationFailure extends CategoryState {
  final String message;

  const CategoryCreationFailure({required this.message});
}

// update category
class CategoryUpdateSuccess extends CategoryState {
  final String message;

  const CategoryUpdateSuccess({required this.message});
}

class CategoryUpdateFailure extends CategoryState {
  final String message;

  const CategoryUpdateFailure({required this.message});
}
