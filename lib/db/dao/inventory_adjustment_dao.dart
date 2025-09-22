import 'package:drift/drift.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/db/tables/inventory_adjustments_table.dart';

part 'inventory_adjustment_dao.g.dart';

@DriftAccessor(tables: [InventoryAdjustments])
class InventoryAdjustmentDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryAdjustmentDaoMixin {
  final AppDatabase db;

  InventoryAdjustmentDao(this.db) : super(db);

  Future<List<AdjustmentType>> searchAdjustmentTypes(String filter) {
    return (select(db.adjustmentTypes)
          ..limit(AppConstants.listResultsLimit)
          ..orderBy([(t) => OrderingTerm.asc(t.increasesStock)]))
        .get();
  }

  /*Future<int> createOrUpdateInventoryAdjustment(
    InventoryAdjustmentsCompanion inventoryAdjustmentCompanion,
    RecordAction recordAction,
  ) async {
    return transaction(() async {
      // update stock
      final product =
          await (select(db.products)..where(
                (t) =>
                    t.id.equals(inventoryAdjustmentCompanion.productId.value),
              ))
              .getSingleOrNull();

      final adjustmentType =
          await (select(db.adjustmentTypes)..where(
                (t) => t.id.equals(
                  inventoryAdjustmentCompanion.adjustmentTypeId.value,
                ),
              ))
              .getSingleOrNull();

      if (product == null || adjustmentType == null) return -1;

      if (product.trackStock && adjustmentType.increasesStock) {
        await db.productDao.updateStockProduct(
          productId: product.id,
          quantityChange: inventoryAdjustmentCompanion.quantity.value,
        );
      } else if (product.trackStock && !adjustmentType.increasesStock) {
        await db.productDao.updateStockProduct(
          productId: product.id,
          quantityChange: inventoryAdjustmentCompanion.quantity.value * -1,
        );
      }

      if (recordAction == RecordAction.create) {
        return into(inventoryAdjustments).insert(inventoryAdjustmentCompanion);
      } else {
        final id = inventoryAdjustmentCompanion.id.value;
        final rowsUpdated =
            await (update(inventoryAdjustments)
                  ..where((tbl) => tbl.id.equals(id)))
                .write(inventoryAdjustmentCompanion);

        return rowsUpdated > 0 ? id : -1;
      }
    });
  }*/

  Future<int> createOrUpdateInventoryAdjustment(
    InventoryAdjustmentsCompanion inventoryAdjustmentCompanion,
    RecordAction recordAction,
  ) async {
    return transaction(() async {
      // Datos del ajuste nuevo
      final newProduct =
          await (select(db.products)..where(
                (t) =>
                    t.id.equals(inventoryAdjustmentCompanion.productId.value),
              ))
              .getSingleOrNull();
      final newAdjustmentType =
          await (select(db.adjustmentTypes)..where(
                (t) => t.id.equals(
                  inventoryAdjustmentCompanion.adjustmentTypeId.value,
                ),
              ))
              .getSingleOrNull();

      if (newProduct == null || newAdjustmentType == null) return -1;

      // Helper: valor con signo del ajuste: +qty si increasesStock, -qty si no
      double signedFor(bool increases, double qty) => increases ? qty : -qty;

      if (recordAction == RecordAction.create) {
        // CREATE: aplicar efecto del ajuste nuevo
        if (newProduct.trackStock) {
          final qtyChange = signedFor(
            newAdjustmentType.increasesStock,
            inventoryAdjustmentCompanion.quantity.value,
          );
          await db.productDao.updateStockProduct(
            productId: newProduct.id,
            quantityChange: qtyChange,
          );
        }
        return into(inventoryAdjustments).insert(inventoryAdjustmentCompanion);
      } else {
        // UPDATE: necesitamos el ajuste anterior para calcular la diferencia
        final id = inventoryAdjustmentCompanion.id.value;
        final previous = await (select(
          inventoryAdjustments,
        )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

        if (previous == null) return -1;

        final prevAdjustmentType =
            await (select(db.adjustmentTypes)
                  ..where((t) => t.id.equals(previous.adjustmentTypeId)))
                .getSingleOrNull();

        if (prevAdjustmentType == null) return -1;

        // Caso 1: mismo producto -> aplicar cambio neto
        if (previous.productId ==
            inventoryAdjustmentCompanion.productId.value) {
          final prevSigned = signedFor(
            prevAdjustmentType.increasesStock,
            previous.quantity,
          );
          final newSigned = signedFor(
            newAdjustmentType.increasesStock,
            inventoryAdjustmentCompanion.quantity.value,
          );
          final netChange =
              newSigned -
              prevSigned; // si positivo => sumar, si negativo => restar

          if (newProduct.trackStock && netChange != 0) {
            await db.productDao.updateStockProduct(
              productId: newProduct.id,
              quantityChange: netChange,
            );
          }
        } else {
          // Caso 2: cambió el producto -> revertir efecto en producto anterior y aplicar en producto nuevo
          final prevProduct = await (select(
            db.products,
          )..where((t) => t.id.equals(previous.productId))).getSingleOrNull();

          // Revertir en producto anterior (si aún existe y trackStock = true)
          if (prevProduct != null && prevProduct.trackStock) {
            final prevEffect = signedFor(
              prevAdjustmentType.increasesStock,
              previous.quantity,
            );
            // Para revertir aplicamos el negativo de lo que se aplicó antes
            await db.productDao.updateStockProduct(
              productId: prevProduct.id,
              quantityChange: -prevEffect,
            );
          }

          // Aplicar en producto nuevo
          if (newProduct.trackStock) {
            final newEffect = signedFor(
              newAdjustmentType.increasesStock,
              inventoryAdjustmentCompanion.quantity.value,
            );
            await db.productDao.updateStockProduct(
              productId: newProduct.id,
              quantityChange: newEffect,
            );
          }
        }

        final rowsUpdated =
            await (update(inventoryAdjustments)
                  ..where((tbl) => tbl.id.equals(id)))
                .write(inventoryAdjustmentCompanion);

        return rowsUpdated > 0 ? id : -1;
      }
    });
  }

  Future<int> softDeleteInventoryAdjustment(int id) {
    return transaction(() async {
      // Buscar el ajuste
      final adjustment = await (select(
        inventoryAdjustments,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      if (adjustment == null) return -1;

      // Buscar el producto relacionado
      final product = await (select(
        db.products,
      )..where((t) => t.id.equals(adjustment.productId))).getSingleOrNull();

      // Buscar el tipo de ajuste
      final adjustmentType =
          await (select(db.adjustmentTypes)
                ..where((t) => t.id.equals(adjustment.adjustmentTypeId)))
              .getSingleOrNull();

      if (product == null || adjustmentType == null) return -1;

      // Revertir el cambio en stock si el producto se controla
      if (product.trackStock) {
        final quantityChange = adjustmentType.increasesStock
            ? -adjustment
                  .quantity // si sumaba stock, ahora lo restamos
            : adjustment.quantity; // si restaba stock, ahora lo sumamos

        await db.productDao.updateStockProduct(
          productId: product.id,
          quantityChange: quantityChange,
        );
      }

      // Hacer soft delete del ajuste
      final rowsUpdated =
          await (update(
            inventoryAdjustments,
          )..where((t) => t.id.equals(id))).write(
            const InventoryAdjustmentsCompanion(
              status: Value(RecordStatus.deleted),
            ),
          );

      return rowsUpdated;
    });
  }

  Future<List<Map<String, dynamic>>> getInventoryAdjustmentsWithDetails(
    int cashRegisterId,
  ) async {
    final query = selectOnly(inventoryAdjustments)
      ..addColumns([
        inventoryAdjustments.id,
        inventoryAdjustments.productId,
        inventoryAdjustments.adjustmentTypeId,
        inventoryAdjustments.quantity,
        inventoryAdjustments.description,
        inventoryAdjustments.status,
      ])
      ..join([
        leftOuterJoin(
          db.products,
          db.products.id.equalsExp(inventoryAdjustments.productId),
        ),
        leftOuterJoin(
          db.adjustmentTypes,
          db.adjustmentTypes.id.equalsExp(
            inventoryAdjustments.adjustmentTypeId,
          ),
        ),
      ])
      ..addColumns([
        db.products.name,
        db.adjustmentTypes.name,
        db.adjustmentTypes.increasesStock,
      ])
      ..where(
        inventoryAdjustments.status.equals(RecordStatus.active.name) &
            inventoryAdjustments.cashRegisterId.equals(cashRegisterId),
      )
      ..orderBy([OrderingTerm.desc(inventoryAdjustments.createdAt)])
      ..limit(AppConstants.listResultsLimit);

    final rows = await query.get();

    return rows.map((row) {
      return {
        'id': row.read(inventoryAdjustments.id),
        'productId': row.read(inventoryAdjustments.productId),
        'adjustmentTypeId': row.read(inventoryAdjustments.adjustmentTypeId),
        'quantity': row.read(inventoryAdjustments.quantity),
        'description': row.read(inventoryAdjustments.description),
        'status': row.read(inventoryAdjustments.status),
        'productName': row.read(db.products.name),
        'adjustmentTypeName': row.read(
          db.adjustmentTypes.name,
        ), // aquí obtienes el nombre del tipo
        'adjustmentTypeIncreasesStock': row.read(
          db.adjustmentTypes.increasesStock,
        ),
      };
    }).toList();
  }

  Future<AdjustmentType?> getById(int id) {
    return (select(
      db.adjustmentTypes,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
