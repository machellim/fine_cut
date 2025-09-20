// seed_data.dart

import 'package:fine_cut/db/database.dart';
import 'package:drift/drift.dart';

Future<void> insertInitialData(AppDatabase db) async {
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

  // ================= Insert Adjustments Types =================
  final adjustmentTypes = [
    // Types that decrease stock
    {'name': 'Pérdida por daño', 'increasesStock': false}, // Product damaged
    {
      'name': 'Pérdida por vencimiento',
      'increasesStock': false,
    }, // Product expired
    {'name': 'Pérdida por robo', 'increasesStock': false}, // Product stolen
    {
      'name': 'Devolución no recuperable',
      'increasesStock': false,
    }, // Cannot be resold
    {'name': 'Uso interno', 'increasesStock': false}, // Internal consumption
    {'name': 'Ajuste negativo', 'increasesStock': false}, // Manual reduction
    // Types that increase stock
    {'name': 'Devolución recuperable', 'increasesStock': true}, // Can be resold
    {'name': 'Reposición', 'increasesStock': true}, // Stock added
    {'name': 'Ajuste positivo', 'increasesStock': true}, // Manual addition
  ];

  for (var type in adjustmentTypes) {
    final exists = await (db.select(
      db.adjustmentTypes,
    )..where((lt) => lt.name.equals(type['name'] as String))).getSingleOrNull();

    if (exists == null) {
      await db
          .into(db.adjustmentTypes)
          .insert(
            AdjustmentTypesCompanion.insert(
              name: type['name'] as String,
              increasesStock: Value(type['increasesStock'] as bool),
            ),
          );
    }
  }
}
