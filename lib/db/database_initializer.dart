import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/database_singleton.dart';
import 'package:drift/drift.dart';

Future<AppDatabase> initializeDatabase() async {
  try {
    //await dotenv.load(); // Solo si usas .env
    final database = await AppDatabaseSingleton.getInstance();
    return database;
  } catch (e) {
    print('Error al inicializar la base de datos: $e');
    rethrow;
  }
}
