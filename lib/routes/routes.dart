import 'package:fine_cut/screens/admin/payment_method_list.dart';
import 'package:fine_cut/screens/cash_register/main_cash_register.dart';
import 'package:fine_cut/screens/cash_register/new_cash_register.dart';
import 'package:fine_cut/screens/cash_register/view_edit_cash_register.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'main-cash-register': (BuildContext context) {
    return MainCashRegisterScreen();
  },
  'new-cash-register': (BuildContext context) {
    return NewCashRegisterScreen();
  },
  'payment-method-list': (BuildContext context) {
    return PaymentMethodListScreen();
  },
  'view-edit-cash-register': (BuildContext context) {
    return ViewEditCashRegisterScreen();
  },
};

/*Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'check-totals':
      final user = settings.arguments as User;
      return MaterialPageRoute(
        builder: (context) => CheckTotalsScreen(user: user),
      );
    default:
      return null; // o una ruta por defecto
  }
}*/
