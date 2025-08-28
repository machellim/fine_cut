part of 'payment_method_list_bloc.dart';

sealed class PaymentMethodListEvent extends Equatable {
  const PaymentMethodListEvent();

  @override
  List<Object> get props => [];
}

// === Event to load payment methods ===
class LoadPaymentMethodsEvent extends PaymentMethodListEvent {
  final String executeFrom; // list, create, update

  const LoadPaymentMethodsEvent(this.executeFrom);

  @override
  List<Object> get props => [executeFrom];
}
