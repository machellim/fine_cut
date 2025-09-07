import 'package:fine_cut/bloc/cash_register/cash_register_last_closed/cash_register_last_closed_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart' show AppMessages;
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_body.dart';
import 'package:fine_cut/widgets/app_drawer.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart' show AppLoadingScreen;
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCashRegisterScreen extends StatefulWidget {
  const MainCashRegisterScreen({super.key});
  @override
  State<MainCashRegisterScreen> createState() => _MainCashRegisterScreenState();
}

class _MainCashRegisterScreenState extends State<MainCashRegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    context.read<CashRegisterLastClosedBloc>().add(
      GetCashRegisterLastClosedEvent(CashRegisterStatus.closed),
    );
  }

  @override
  Widget build(BuildContext context) {
    // cashStatusRepository.clearAllTables();
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Información Caja Anterior"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: AppDrawer(appContext: context),
      body: AppBody(
        child: Padding(
          padding: const EdgeInsets.only(top: 64, right: 16, left: 16),
          child: Column(
            children: [
              BlocBuilder<
                CashRegisterLastClosedBloc,
                CashRegisterLastClosedState
              >(
                builder: (context, state) {
                  if (state is GetCashRegisterLastClosedLoading) {
                    return Expanded(
                      flex: 1,
                      child: AppLoadingScreen(
                        message: AppMessages.getCashRegistersMessage(
                          'messageLoadingCashRegisterLastClosed',
                        ),
                      ),
                    );
                  } else if (state is GetCashRegisterLastClosedLoadSuccess) {
                    final cashRegister = state.cashRegister;
                    if (state.cashRegister == null) {
                      return Expanded(
                        flex: 1,
                        child: Center(
                          child: AppMessageType(
                            message: AppMessages.getAppMessage('emptyList'),
                            messageType: MessageType.info,
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.surface.withValues(alpha: 0.1),
                              theme.colorScheme.primary.withValues(alpha: 0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Encabezado
                            Row(
                              children: [
                                Icon(
                                  Icons.point_of_sale,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Caja Anterior",
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Fecha y Status destacados
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      AppUtils.formatDate(
                                        cashRegister.registerDate,
                                      ),
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    cashRegister.status ==
                                            CashRegisterStatus.closed
                                        ? 'Cerrada'
                                        : 'Abierta',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Saldo inicial / final
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildAmountBox(
                                  "Saldo Inicial",
                                  AppUtils.formatDouble(
                                    cashRegister.openingAmount,
                                  ),
                                  theme,
                                ),
                                _buildAmountBox(
                                  "Saldo Final",
                                  AppUtils.formatDouble(
                                    cashRegister.closingAmount ?? 0,
                                  ),
                                  theme,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Total ventas
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white70,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Total Ventas: \$ ${cashRegister.totalSales}",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Notas
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.note_alt,
                                  color: Colors.white70,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    cashRegister.notes ?? '',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is GetCashRegisterLastClosedLoadFailure) {
                    return Expanded(
                      flex: 1,
                      child: Center(child: Text(state.message)),
                    );
                  } else {
                    return Expanded(
                      flex: 1,
                      child: const Center(child: Text('Estado desconocido')),
                    );
                  }
                },
              ),
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
                        Navigator.pushNamed(context, 'new-cash-register');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.point_of_sale,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountBox(String label, String value, ThemeData theme) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
