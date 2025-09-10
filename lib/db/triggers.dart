// database_triggers.dart
import 'package:drift/drift.dart';

class DatabaseTriggers {
  /// Trigger para actualizar automáticamente el campo updated_at en la tabla categories
  static const String setCategoriesUpdatedAt = '''
    CREATE TRIGGER set_updated_at_on_categories
    AFTER UPDATE ON categories
    BEGIN
      UPDATE categories
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_cash_registers
    AFTER UPDATE ON cash_registers
    BEGIN
      UPDATE cash_registers
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_expenses
    AFTER UPDATE ON expenses
    BEGIN
      UPDATE expenses
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_incomes
    AFTER UPDATE ON incomes
    BEGIN
      UPDATE incomes
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_payment_methods
    AFTER UPDATE ON payment_methods
    BEGIN
      UPDATE payment_methods
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_products
    AFTER UPDATE ON products
    BEGIN
      UPDATE products
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_purchases
    AFTER UPDATE ON purchases
    BEGIN
      UPDATE purchases
      SET updated_at = strftime('%s','now')
      WHERE id = NEW.id;
    END;

    CREATE TRIGGER set_updated_at_on_sales
    AFTER UPDATE ON sales
    BEGIN
      UPDATE sales
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
