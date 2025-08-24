import 'package:fine_cut/db/database.dart';

class AppDatabaseSingleton {
  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    _instance ??= AppDatabase(); // tu constructor sigue funcionando igual
    return _instance!;
  }

  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
