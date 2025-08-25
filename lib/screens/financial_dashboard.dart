import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_body.dart';
import 'package:fine_cut/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinancialDashboardScreen extends StatefulWidget {
  const FinancialDashboardScreen({super.key});
  @override
  State<FinancialDashboardScreen> createState() =>
      _FinancialDashboardScreenState();
}

class _FinancialDashboardScreenState extends State<FinancialDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // cashStatusRepository.clearAllTables();
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Estado de Caja"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: AppDrawer(appContext: context),
      body: AppBody(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors
                                  .grey
                                  .shade400 // borde gris claro en light mode
                            : Colors
                                  .grey
                                  .shade700, // borde más oscuro en dark mode
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200.withAlpha(
                                  (0.5 * 255).toInt(),
                                ) // sombra ligera en light
                              : Colors.black.withAlpha(
                                  (0.5 * 255).toInt(),
                                ), // sombra en dark
                          blurRadius: 10,
                          offset: Offset(4, 4), // dirección de la sombra
                        ),
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? Colors.white.withAlpha((0.8 * 255).toInt())
                              // luz suave para efecto levantado
                              : Colors.grey.shade800.withAlpha(
                                  (0.3 * 255).toInt(),
                                ),
                          blurRadius: 6,
                          offset: Offset(-2, -2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        // Acción para crear nueva caja
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              size: 32,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Crear\nNueva Caja",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withAlpha(
                      (0.8 * 255).toInt(),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Sección pendiente",
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withAlpha(180),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
