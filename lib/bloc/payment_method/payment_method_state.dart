part of 'payment_method_bloc.dart';

sealed class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object> get props => [];
}

final class PaymentMethodInitial extends PaymentMethodState {}

// === states to load payment methods ===
class PaymentMethodsLoading extends PaymentMethodState {}

class PaymentMethodsLoadSuccess extends PaymentMethodState {
  final List<PaymentMethod> paymentMethods;

  const PaymentMethodsLoadSuccess(this.paymentMethods);
}

class PaymentMethodsLoadFailure extends PaymentMethodState {
  final String message;

  const PaymentMethodsLoadFailure({required this.message});
}
