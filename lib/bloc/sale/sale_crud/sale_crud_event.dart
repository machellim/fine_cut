part of 'sale_crud_bloc.dart';

sealed class SaleCrudEvent extends Equatable {
  const SaleCrudEvent();

  @override
  List<Object> get props => [];
}

// create or update sale
class CreateSaleEvent extends SaleCrudEvent {
  final RecordAction recordAction;
  final SalesCompanion saleCompanion;
  final Product selectedProduct;

  const CreateSaleEvent(
    this.recordAction,
    this.saleCompanion,
    this.selectedProduct,
  );

  @override
  List<Object> get props => [recordAction, saleCompanion, selectedProduct];
}

// delete sale (soft delete)
class DeleteSaleEvent extends SaleCrudEvent {
  final int saleId;

  const DeleteSaleEvent(this.saleId);

  @override
  List<Object> get props => [saleId];
}
