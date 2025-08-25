import 'package:drift/drift.dart';
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
}
