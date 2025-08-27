import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_method_crud_event.dart';
part 'payment_method_crud_state.dart';

class PaymentMethodCrudBloc extends Bloc<PaymentMethodCrudEvent, PaymentMethodCrudState> {
  PaymentMethodCrudBloc() : super(PaymentMethodCrudInitial()) {
    on<PaymentMethodCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
