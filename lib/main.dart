import 'package:drift/drift.dart';
import 'package:fine_cut/bloc/bloc_observer.dart';
import 'package:fine_cut/bloc/cash_register/available_balance/available_balance_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_can_edit/cash_register_can_edit_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_close/cash_register_close_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_crud/cash_register_crud_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_data/cash_register_data_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_last_closed/cash_register_last_closed_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_list/cash_register_list_bloc.dart';
import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_bloc.dart';
import 'package:fine_cut/bloc/category/search_categories/search_categories_bloc.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_crud/payment_method_crud_bloc.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/bloc/product/product_crud/product_crud_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_crud/purchase_crud_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_list/purchase_list_bloc.dart';
import 'package:fine_cut/bloc/reports/parent_product_purchases_list/parent_product_purchases_list_bloc.dart';
import 'package:fine_cut/bloc/reports/parent_product_sales_list/parent_product_sales_list_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_crud/sale_crud_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_list/sale_list_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_parent_product/sale_parent_product_bloc.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/database_initializer.dart';
import 'package:fine_cut/routes/routes.dart';
import 'package:fine_cut/screens/cash_register/new_cash_register.dart';
import 'package:fine_cut/screens/cash_register/view_edit_cash_register.dart';
import 'package:fine_cut/screens/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fine_cut/screens/cash_register/main_cash_register.dart';

void main() {
  // Bloc.observer = AppBlocObserver();
  runApp(AppInitializer());
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future: initializeDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ), // Muestra un loading mientras carga
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing database'),
              ), // Muestra un error si falla la inicialización
            ),
          );
        } else if (snapshot.hasData) {
          final database = snapshot.data!;

          // to create db if not exists in the directory
          database.allTables.forEach((TableInfo table) async {
            final count = await database.select(table).get();
            print('${table.actualTableName}');
          });

          // daos
          final paymentMethodDao = database.paymentMethodDao;
          final cashRegisterDao = database.cashRegisterDao;
          final categoryDao = database.categoryDao;
          final productDao = database.productDao;
          final purchaseDao = database.purchaseDao;
          final saleDao = database.saleDao;
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AppDatabase>(create: (_) => database),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<CashRegisterDataBloc>(
                  create: (_) =>
                      CashRegisterDataBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<PaymentMethodListBloc>(
                  create: (_) =>
                      PaymentMethodListBloc(paymentMethodDao: paymentMethodDao),
                ),
                BlocProvider<PaymentMethodCrudBloc>(
                  create: (_) =>
                      PaymentMethodCrudBloc(paymentMethodDao: paymentMethodDao),
                ),
                BlocProvider<CashRegisterCrudBloc>(
                  create: (_) =>
                      CashRegisterCrudBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<CategoryBloc>(
                  create: (_) => CategoryBloc(categoryDao: categoryDao),
                ),
                BlocProvider<CategoriesListBloc>(
                  create: (_) => CategoriesListBloc(categoryDao: categoryDao),
                ),
                BlocProvider<ProductsListBloc>(
                  create: (_) => ProductsListBloc(productDao: productDao),
                ),
                BlocProvider<ProductCrudBloc>(
                  create: (_) => ProductCrudBloc(productDao: productDao),
                ),
                BlocProvider<SearchCategoriesBloc>(
                  create: (_) => SearchCategoriesBloc(categoryDao: categoryDao),
                ),
                BlocProvider<PurchaseCrudBloc>(
                  create: (_) => PurchaseCrudBloc(purchaseDao: purchaseDao),
                ),
                BlocProvider<SaleCrudBloc>(
                  create: (_) => SaleCrudBloc(saleDao: saleDao),
                ),
                BlocProvider<PurchaseListBloc>(
                  create: (_) => PurchaseListBloc(purchaseDao: purchaseDao),
                ),
                BlocProvider<SaleListBloc>(
                  create: (_) => SaleListBloc(saleDao: saleDao),
                ),
                BlocProvider<AvailableBalanceBloc>(
                  create: (_) =>
                      AvailableBalanceBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<CashRegisterCloseBloc>(
                  create: (_) =>
                      CashRegisterCloseBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<CashRegisterListBloc>(
                  create: (_) =>
                      CashRegisterListBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<CashRegisterCanEditBloc>(
                  create: (_) =>
                      CashRegisterCanEditBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<SaleParentProductBloc>(
                  create: (_) => SaleParentProductBloc(saleDao: saleDao),
                ),
                BlocProvider<ParentProductPurchasesListBloc>(
                  create: (_) =>
                      ParentProductPurchasesListBloc(purchaseDao: purchaseDao),
                ),
                BlocProvider<ParentProductSalesListBloc>(
                  create: (_) => ParentProductSalesListBloc(saleDao: saleDao),
                ),
                BlocProvider<CashRegisterLastClosedBloc>(
                  create: (_) => CashRegisterLastClosedBloc(
                    cashRegisterDao: cashRegisterDao,
                  ),
                ),
              ],
              child: FineCutApp(database: database),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error initializing database 2.')),
            ),
          );
        }
      },
    );
  }
}

class FineCutApp extends StatelessWidget {
  final AppDatabase database;

  const FineCutApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cajamiga',

      // Light Theme
      theme:
          ThemeData.from(
            colorScheme: ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              secondary: Colors.deepPurpleAccent,
              onSecondary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              brightness: Brightness.light,
            ),
            textTheme: ThemeData.light().textTheme,
          ).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // botón claro
                foregroundColor: Colors.white, // texto blanco
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
          ),
      darkTheme:
          ThemeData.from(
            colorScheme: ColorScheme.dark(
              primary: Colors.indigoAccent,
              onPrimary: Colors.black,
              secondary: Colors.deepPurpleAccent,
              onSecondary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.white,
              brightness: Brightness.dark,
            ),
            textTheme: ThemeData.dark().textTheme,
          ).copyWith(
            scaffoldBackgroundColor: Colors.black,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent, // botón oscuro
                foregroundColor: Colors.black, // texto oscuro
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
          ),
      themeMode: ThemeMode.system,

      // o .dark, .light
      debugShowCheckedModeBanner: false,
      home: HomeWrapper(database: database),
      routes: appRoutes,
      onGenerateRoute: generateRoute,
    );
  }
}
