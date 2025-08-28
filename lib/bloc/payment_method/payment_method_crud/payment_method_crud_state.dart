part of 'payment_method_crud_bloc.dart';

sealed class PaymentMethodCrudState extends Equatable {
  const PaymentMethodCrudState();

  @override
  List<Object> get props => [];
}

final class PaymentMethodCrudInitial extends PaymentMethodCrudState {}

// create payment method
class PaymentMethodCreationInProgress extends PaymentMethodCrudState {}

class PaymentMethodCreationSuccess extends PaymentMethodCrudState {
  final PaymentMethod? paymentMethod;

  const PaymentMethodCreationSuccess(this.paymentMethod);
}

class PaymentMethodCreationFailure extends PaymentMethodCrudState {
  final String message;

  const PaymentMethodCreationFailure({required this.message});
}

// update category
class PaymentMethodUpdateSuccess extends PaymentMethodCrudState {
  final String message;

  const PaymentMethodUpdateSuccess({required this.message});
}

class PaymentMethodUpdateFailure extends PaymentMethodCrudState {
  final String message;

  const PaymentMethodUpdateFailure({required this.message});
}
