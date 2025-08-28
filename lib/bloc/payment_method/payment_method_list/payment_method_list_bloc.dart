import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/payment_method_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'payment_method_list_event.dart';
part 'payment_method_list_state.dart';

class PaymentMethodListBloc
    extends Bloc<PaymentMethodListEvent, PaymentMethodListState> {
  final PaymentMethodDao paymentMethodDao;
  PaymentMethodListBloc({required this.paymentMethodDao})
    : super(PaymentMethodInitial()) {
    on<PaymentMethodListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadPaymentMethodsEvent>((event, emit) async {
      emit(PaymentMethodsLoading());
      //await Future.delayed(Duration(seconds: 3));
      try {
        final investments = await paymentMethodDao.getAllPaymentMethods();
        emit(PaymentMethodsLoadSuccess(investments, event.eventSource));
      } catch (e) {
        emit(PaymentMethodsLoadFailure(message: e.toString()));
      }
    });
  }
}
