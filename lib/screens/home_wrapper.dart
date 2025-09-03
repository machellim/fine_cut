import 'package:flutter/material.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/screens/cash_register/main_cash_register.dart';
import 'package:fine_cut/screens/cash_register/view_edit_cash_register.dart';

class HomeWrapper extends StatelessWidget {
  final AppDatabase database;

  const HomeWrapper({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CashRegister?>(
      future: database.cashRegisterDao.getLastOpenCashRegister(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          // No hay caja abierta → ir a la pantalla principal de cajas
          return MainCashRegisterScreen();
        } else {
          // Hay caja abierta → ir a la pantalla de vista/edición de la caja
          final cashRegister = snapshot.data!;
          return ViewEditCashRegisterScreen(cashRegister: cashRegister);
        }
      },
    );
  }
}
