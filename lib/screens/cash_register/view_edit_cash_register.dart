import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';

class ViewEditCashRegisterScreen extends StatefulWidget {
  const ViewEditCashRegisterScreen({super.key});

  @override
  State<ViewEditCashRegisterScreen> createState() =>
      _ViewEditCashRegisterScreenState();
}

class _ViewEditCashRegisterScreenState
    extends State<ViewEditCashRegisterScreen> {
  bool isNew = true;

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return AppScaffold(
      appBar: AppBarCustom(
        title: isNew ? 'Ventas' : 'Editar Caja',
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'close-cash-register') {
                // acción de cerrar caja
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'close-cash-register',
                child: Text('Cerrar Caja'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
        child: Column(
          children: [
            // Fila de Fecha y Saldo Inicial
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Fecha:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(today),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Saldo Inicial:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$25000.00'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ExpansionPanelList.radio con primer panel abierto por defecto
            ExpansionPanelList.radio(
              initialOpenPanelValue: 0, // <-- Aquí se abre el primer panel
              children: [
                ExpansionPanelRadio(
                  value: 0,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Ventas del día')),
                  body: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppButton(title: 'Agregar Venta', onPressed: () {}),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap:
                              true, // importante para que funcione dentro de Column
                          physics:
                              const NeverScrollableScrollPhysics(), // evita scroll interno
                          itemCount: 5, // número de elementos
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                AppListItem(
                                  title: Text(
                                    'product',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  description: Text('2'),
                                  price: 5,
                                  onEdit: () {},

                                  onDelete: () {},
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: Text('Compras')),
                  body: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Contenido de compras'),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 2,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: Text('Otros Gastos')),
                  body: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Contenido de otros gastos'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
