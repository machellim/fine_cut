part of 'payment_method_crud_bloc.dart';

sealed class PaymentMethodCrudState extends Equatable {
  const PaymentMethodCrudState();
  
  @override
  List<Object> get props => [];
}

final class PaymentMethodCrudInitial extends PaymentMethodCrudState {}
