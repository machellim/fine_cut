import 'package:drift/drift.dart';
import 'package:fine_cut/core/enums/enums.dart';
import '../database.dart';

import '../tables/payment_methods_table.dart';

part 'payment_method_dao.g.dart';

@DriftAccessor(tables: [PaymentMethods])
class PaymentMethodDao extends DatabaseAccessor<AppDatabase>
    with _$PaymentMethodDaoMixin {
  final AppDatabase db;

  PaymentMethodDao(this.db) : super(db);

  Future<List<PaymentMethod>> getAllPaymentMethods() {
    return (select(
      paymentMethods,
    )..orderBy([(t) => OrderingTerm.asc(t.displayOrder)])).get();
  }

  Future<bool> _isNameTaken(String name, {int? excludeId}) async {
    final normalizedName = name.toLowerCase();
    final conflict =
        await (select(paymentMethods)
              ..where((tbl) => tbl.name.lower().equals(normalizedName)))
            .getSingleOrNull();

    if (conflict == null) return false;
    if (excludeId != null && conflict.id == excludeId) return false;
    return true;
  }

  Future<PaymentMethod?> createPaymentMethod({
    required String name,
    required int displayOrder,
    String? description,
  }) async {
    if (await _isNameTaken(name)) return null;

    final companion = PaymentMethodsCompanion.insert(
      name: name,
      displayOrder: Value(displayOrder),
      description: Value(description),
    );
    return await into(paymentMethods).insertReturning(companion);
  }

  Future<PaymentMethod?> updatePaymentMethod({
    required int id,
    required String name,
    required int displayOrder,
    String? description,
    AppActiveStatus status = AppActiveStatus.active,
  }) async {
    if (await _isNameTaken(name, excludeId: id)) return null;

    final companion = PaymentMethodsCompanion(
      name: Value(name),
      description: Value(description),
      displayOrder: Value(displayOrder),
      status: Value(status),
    );

    await (update(
      paymentMethods,
    )..where((tbl) => tbl.id.equals(id))).write(companion);

    return await (select(
      paymentMethods,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
