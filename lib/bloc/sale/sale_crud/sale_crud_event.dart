part of 'sale_crud_bloc.dart';

sealed class SaleCrudEvent extends Equatable {
  const SaleCrudEvent();

  @override
  List<Object> get props => [];
}

// create or update sale
class CreateSaleEvent extends SaleCrudEvent {
  final String action;
  final SalesCompanion sale;

  const CreateSaleEvent(this.action, this.sale);

  @override
  List<Object> get props => [action, sale];
}
