import 'package:drift/drift.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_crud/cash_register_crud_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_data/cash_register_data_bloc.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_bloc.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/database_initializer.dart';
import 'package:fine_cut/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fine_cut/screens/cash_register/main_cash_register.dart';

void main() {
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
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AppDatabase>(create: (_) => database),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<CashRegisterBloc>(
                  create: (_) =>
                      CashRegisterBloc(cashRegisterDao: cashRegisterDao),
                ),
                BlocProvider<PaymentMethodBloc>(
                  create: (_) =>
                      PaymentMethodBloc(paymentMethodDao: paymentMethodDao),
                ),
                BlocProvider<CashRegisterCrudBloc>(
                  create: (_) =>
                      CashRegisterCrudBloc(cashRegisterDao: cashRegisterDao),
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
              primary: Colors.deepPurple,
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
      home: MainCashRegisterScreen(),
      routes: appRoutes,
      //onGenerateRoute: generateRoute,
    );
  }
}
