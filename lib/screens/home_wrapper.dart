import 'package:fine_cut/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/screens/cash_register/main_cash_register.dart';
import 'package:fine_cut/screens/cash_register/view_edit_cash_register.dart';

class HomeWrapper extends StatefulWidget {
  final AppDatabase database;

  const HomeWrapper({super.key, required this.database});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> with WidgetsBindingObserver {
  DateTime? _lastBackPressTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastBackPressTime = null;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _lastBackPressTime = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reinicia el estado cada vez que se navega a esta pantalla
    _lastBackPressTime = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reinicia el estado cada vez que la app vuelve al primer plano.
      _lastBackPressTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          return;
        }
        final now = DateTime.now();
        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
          _lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Presiona atrás nuevamente para salir'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          _lastBackPressTime = null;
          SystemNavigator.pop();
        }
      },
      child: FutureBuilder<CashRegister?>(
        future: widget.database.cashRegisterDao.getLastCashRegisterByStatus(
          CashRegisterStatus.open,
        ),
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
            // No hay caja abierta
            return MainCashRegisterScreen();
          } else {
            // Hay caja abierta
            final cashRegister = snapshot.data!;
            return ViewEditCashRegisterScreen(cashRegister: cashRegister);
          }
        },
      ),
    );
  }
}
