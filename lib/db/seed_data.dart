// seed_data.dart

import 'package:fine_cut/db/database.dart';
import 'package:drift/drift.dart';

Future<void> insertInitialData(AppDatabase db) async {
  // Insert unit types if they don't exist
  // Example:Units
  final unitExists = await (db.select(
    db.units,
  )..where((u) => u.name.equals('Unidades'))).getSingleOrNull();
  if (unitExists == null) {
    await db
        .into(db.units)
        .insert(
          UnitsCompanion.insert(
            name: 'Unidades',
            symbol: 'uds', // Encriptar idealmente
          ),
        );
  }

  // Example: Pounds
  final lbExists = await (db.select(
    db.units,
  )..where((u) => u.name.equals('Libras'))).getSingleOrNull();

  if (lbExists == null) {
    await db
        .into(db.units)
        .insert(UnitsCompanion.insert(name: 'Libras', symbol: 'lb'));
  }
  // Example: Kilograms
  final kgExists = await (db.select(
    db.units,
  )..where((u) => u.name.equals('Kilogramos'))).getSingleOrNull();

  if (kgExists == null) {
    await db
        .into(db.units)
        .insert(UnitsCompanion.insert(name: 'Kilogramos', symbol: 'kg'));
  }

  // Example: Ounces
  final ozExists = await (db.select(
    db.units,
  )..where((u) => u.name.equals('Onzas'))).getSingleOrNull();
  if (ozExists == null) {
    await db
        .into(db.units)
        .insert(UnitsCompanion.insert(name: 'Onzas', symbol: 'oz'));
  }
}
