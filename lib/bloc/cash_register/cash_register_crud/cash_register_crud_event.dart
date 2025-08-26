part of 'cash_register_crud_bloc.dart';

sealed class CashRegisterCrudEvent extends Equatable {
  const CashRegisterCrudEvent();

  @override
  List<Object> get props => [];
}

// === Event to load create cash register ===
class CreateCashRegisterEvent extends CashRegisterCrudEvent {
  final String registerDate;
  final double openingAmount;
  final String? notes;

  const CreateCashRegisterEvent({
    required this.registerDate,
    required this.openingAmount,
    this.notes,
  });
}
