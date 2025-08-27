// database_triggers.dart
import 'package:drift/drift.dart';

class DatabaseTriggers {
  /// Trigger para actualizar automáticamente el campo updated_at en la tabla categories
  static const String setCategoriesUpdatedAt = '''
    CREATE TRIGGER set_updated_at
    AFTER UPDATE ON categories
    BEGIN
      UPDATE categories
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;
  ''';

  /// Lista de todos los triggers que se deben crear
  static const List<String> allTriggers = [
    setCategoriesUpdatedAt,
    // Aquí puedes agregar más triggers en el futuro
  ];

  /// Ejecuta todos los triggers definidos
  static Future<void> createAllTriggers(QueryExecutor executor) async {
    for (final trigger in allTriggers) {
      await executor.runCustom(trigger);
    }
  }

  /// Ejecuta un trigger específico
  static Future<void> createTrigger(
    QueryExecutor executor,
    String trigger,
  ) async {
    await executor.runCustom(trigger);
  }
}
