import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
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
import 'package:fine_cut/screens/expenses/new_expense.dart';
import 'package:fine_cut/screens/incomes/new_income.dart';
import 'package:fine_cut/screens/purchases/new_purchase.dart';
import 'package:fine_cut/screens/reports/parent_product_sales_list.dart';
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
  /*'view-edit-cash-register': (BuildContext context) {
    return ViewEditCashRegisterScreen();
  },*/
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
  'new-purchase': (BuildContext context) {
    return NewPurchaseScreen();
  },
  'parent-product-sales-list': (BuildContext context) {
    return ParentProductSalesListScreen();
  },
  'new-expense': (BuildContext context) {
    return NewExpenseScreen();
  },
  'new-income': (BuildContext context) {
    return NewIncomeScreen();
  },
};

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'view-edit-cash-register':
      final cashRegister = settings.arguments as CashRegister;
      return MaterialPageRoute(
        builder: (context) =>
            ViewEditCashRegisterScreen(cashRegister: cashRegister),
      );
    default:
      return null; // o una ruta por defecto
  }
}
