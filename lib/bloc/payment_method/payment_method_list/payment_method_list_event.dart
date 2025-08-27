part of 'payment_method_list_bloc.dart';

sealed class PaymentMethodListEvent extends Equatable {
  const PaymentMethodListEvent();

  @override
  List<Object> get props => [];
}

// === Event to load payment methods ===
class LoadPaymentMethodsEvent extends PaymentMethodListEvent {}
