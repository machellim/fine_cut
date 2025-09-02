import 'package:fine_cut/screens/admin/categories/categories_list.dart';
import 'package:fine_cut/screens/admin/categories/new_category.dart';
import 'package:fine_cut/screens/admin/payment_methods/new_payment_method.dart';
import 'package:fine_cut/screens/admin/payment_methods/payment_method_list.dart';
import 'package:fine_cut/screens/admin/products/new_product.dart';
import 'package:fine_cut/screens/admin/products/products_list.dart';
import 'package:fine_cut/screens/cash_register/cash_register_list.dart';
import 'package:fine_cut/screens/cash_register/main_cash_register.dart';
import 'package:fine_cut/screens/cash_register/new_cash_register.dart';
import 'package:fine_cut/screens/cash_register/view_edit_cash_register.dart';
import 'package:fine_cut/screens/sales/new_sale.dart';
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
  'cash-register-list': (BuildContext context) {
    return CashRegisterListScreen();
  },
  'categories-list': (BuildContext context) {
    return CategoriesListScreen();
  },
  'new-category': (BuildContext context) {
    return NewCategoryScreen();
  },
  'new-payment-method': (BuildContext context) {
    return NewPaymentMethodScreen();
  },
  'product-list': (BuildContext context) {
    return ProductsListScreen();
  },
  'new-product': (BuildContext context) {
    return NewProductScreen();
  },
  'new-sale': (BuildContext context) {
    return NewSaleScreen();
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
