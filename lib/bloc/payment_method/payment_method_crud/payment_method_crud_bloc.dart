import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/db/dao/payment_method_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'payment_method_crud_event.dart';
part 'payment_method_crud_state.dart';

class PaymentMethodCrudBloc
    extends Bloc<PaymentMethodCrudEvent, PaymentMethodCrudState> {
  final PaymentMethodDao paymentMethodDao;
  PaymentMethodCrudBloc({required this.paymentMethodDao})
    : super(PaymentMethodCrudInitial()) {
    on<ResetPaymentMethodCrudEvent>((event, emit) {
      emit(PaymentMethodCrudInitial());
    });
    on<CreatePaymentMethodEvent>((event, emit) async {
      try {
        emit(PaymentMethodCreationInProgress());

        if (event.action == 'create') {
          final paymentMethod = await paymentMethodDao.createPaymentMethod(
            name: event.paymentMethod.name.value,
            description: event.paymentMethod.description.value,
            displayOrder: event.paymentMethod.displayOrder.value,
          );
          if (paymentMethod == null) {
            emit(
              PaymentMethodCreationFailure(
                message:
                    'La Forma de Pago con nombre "${event.paymentMethod.name.value}" ya fue creada.',
              ),
            );
          } else {
            emit(PaymentMethodCreationSuccess(paymentMethod));
          }
        } else if (event.action == 'update') {
          final paymentMethod = await paymentMethodDao.updatePaymentMethod(
            id: event.paymentMethod.id.value,
            name: event.paymentMethod.name.value,
            displayOrder: event.paymentMethod.displayOrder.value,
            description: event.paymentMethod.description.value,
            status: event.paymentMethod.status.value,
          );
          if (paymentMethod == null) {
            emit(
              PaymentMethodUpdateFailure(
                message:
                    'La Forma de Pago con nombre "${event.paymentMethod.name.value}" ya fue creada.',
              ),
            );
          } else {
            emit(
              PaymentMethodUpdateSuccess(
                message: 'Forma de Pago actualizada correctamente.',
              ),
            );
          }
        }
      } catch (e) {
        emit(
          PaymentMethodCreationFailure(
            message: 'Error al procesar Forma de Pago.',
          ),
        );
      }
    });
  }
}
