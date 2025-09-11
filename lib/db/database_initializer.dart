import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/database_singleton.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<AppDatabase> initializeDatabase() async {
  try {
    // 1. Initialize locale data for Spanish
    await initializeDateFormatting('es', null);
    //await dotenv.load(); // Solo si usas .env
    final database = await AppDatabaseSingleton.getInstance();
    return database;
  } catch (e) {
    print('Error al inicializar la base de datos: $e');
    rethrow;
  }
}
