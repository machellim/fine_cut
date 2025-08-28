part of 'payment_method_list_bloc.dart';

sealed class PaymentMethodListState extends Equatable {
  const PaymentMethodListState();

  @override
  List<Object> get props => [];
}

final class PaymentMethodInitial extends PaymentMethodListState {}

// === states to load payment methods ===
class PaymentMethodsLoading extends PaymentMethodListState {}

class PaymentMethodsLoadSuccess extends PaymentMethodListState {
  final List<PaymentMethod> paymentMethods;
  final String executeFrom;

  const PaymentMethodsLoadSuccess(this.paymentMethods, this.executeFrom);
}

class PaymentMethodsLoadFailure extends PaymentMethodListState {
  final String message;

  const PaymentMethodsLoadFailure({required this.message});
}
