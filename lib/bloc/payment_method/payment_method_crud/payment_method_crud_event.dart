part of 'payment_method_crud_bloc.dart';

sealed class PaymentMethodCrudEvent extends Equatable {
  const PaymentMethodCrudEvent();

  @override
  List<Object> get props => [];
}

// event to reset state
class ResetPaymentMethodCrudEvent extends PaymentMethodCrudEvent {}

// create or update payment method
class CreatePaymentMethodEvent extends PaymentMethodCrudEvent {
  final String action;
  final PaymentMethodsCompanion paymentMethod;

  const CreatePaymentMethodEvent(this.action, this.paymentMethod);

  @override
  List<Object> get props => [action, paymentMethod];
}
