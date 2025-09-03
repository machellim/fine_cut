// seed_data.dart

import 'package:fine_cut/db/database.dart';
import 'package:drift/drift.dart';

Future<void> insertInitialData(AppDatabase db) async {
  // Insert unit types if they don't exist
  // Example:Units
  /*final unitExists = await (db.select(
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
  }*/

  // Insert payment methods if they don't exist
  final cashExists = await (db.select(
    db.paymentMethods,
  )..where((pm) => pm.name.equals('Efectivo'))).getSingleOrNull();
  if (cashExists == null) {
    await db
        .into(db.paymentMethods)
        .insert(
          PaymentMethodsCompanion.insert(
            name: 'Efectivo',
            description: Value('Pago en efectivo'),
            displayOrder: Value(1),
          ),
        );
  }

  // Example: Transferencia
  final transferExists = await (db.select(
    db.paymentMethods,
  )..where((pm) => pm.name.equals('Transferencia'))).getSingleOrNull();
  if (transferExists == null) {
    await db
        .into(db.paymentMethods)
        .insert(
          PaymentMethodsCompanion.insert(
            name: 'Transferencia',
            description: Value('Pago por transferencia bancaria'),
            displayOrder: Value(2),
          ),
        );
  }

  // ================= Insert Loss Types =================
  final lossTypes = [
    'Dañado', // Product damaged physically
    'Vencido', // Product expired or perished
    'Robado', // Product lost due to theft
    'Perdido', // Product lost (not found in stock)
    'Otro', // Other type of loss
  ];
  for (var type in lossTypes) {
    final exists = await (db.select(
      db.lossTypes,
    )..where((lt) => lt.name.equals(type))).getSingleOrNull();
    if (exists == null) {
      await db.into(db.lossTypes).insert(LossTypesCompanion.insert(name: type));
    }
  }
}
