import 'package:drift/drift.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/database_initializer.dart';
import 'package:fine_cut/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fine_cut/screens/financial_dashboard.dart';

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
          /*  database.allTables.forEach((TableInfo table) async {
            final count = await database.select(table).get();
            print(
              'Table ${table.actualTableName} has ${count.length} records.',
            );
          });*/

          // daos
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AppDatabase>(create: (_) => database),
            ],
            child: FineCutApp(database: database),
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
              primary: Colors.indigo,
              onPrimary: Colors.white,
              secondary: Colors.deepPurpleAccent,
              onSecondary: Colors.white,
              surface: Colors.white, // en lugar de background
              onSurface: Colors.black,
              brightness: Brightness.light,
            ),
            textTheme: ThemeData.light().textTheme,
          ).copyWith(
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
              primary: Colors.indigo.shade200,
              onPrimary: Colors.black,
              secondary: Colors.deepPurple.shade200,
              onSecondary: Colors.black,
              surface: Colors.black, // en lugar de background
              onSurface: Colors.white,
              brightness: Brightness.dark,
            ),
            textTheme: ThemeData.dark().textTheme,
          ).copyWith(
            scaffoldBackgroundColor: Colors.black,
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
      home: FinancialDashboardScreen(),
      routes: appRoutes,
      //onGenerateRoute: generateRoute,
    );
  }
}
