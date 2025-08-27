import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/database.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

// event to reset state
class ResetCategoryEvent extends CategoryEvent {}

class CreateCategoryEvent extends CategoryEvent {
  final String action;
  final CategoriesCompanion category;

  const CreateCategoryEvent(this.action, this.category);

  @override
  List<Object> get props => [action, category];
}
