part of 'payment_method_bloc.dart';

sealed class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object> get props => [];
}

// === Event to load payment methods ===
class LoadPaymentMethodsEvent extends PaymentMethodEvent {}
