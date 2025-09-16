import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/purchase/parent_product_stock/parent_product_stock_bloc.dart';
import 'package:fine_cut/bloc/reports/product_profit_list/product_profit_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductProfitListScreen extends StatefulWidget {
  const ProductProfitListScreen({super.key});

  @override
  State<ProductProfitListScreen> createState() =>
      _ProductProfitListScreenState();
}

class _ProductProfitListScreenState extends State<ProductProfitListScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    super.initState();

    context.read<ProductProfitListBloc>().add(
      LoadProductProfitListEvent(
        startDate: DateTime(
          DateTime.now().year,
          DateTime.now().month - 1,
          DateTime.now().day,
        ),
        endDate: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Ganancias por Producto"),
      body: BlocBuilder<ProductProfitListBloc, ProductProfitListState>(
        builder: (context, state) {
          if (state is ProductProfitListLoading) {
            return AppLoadingScreen(
              message: AppMessages.getPurchaseMessage('messageLoadingPurchase'),
            );
          } else if (state is ProductProfitListSuccess) {
            if (state.productProfitList.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: AppMessages.getAppMessage('emptyList'),
                  messageType: MessageType.info,
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Fecha inicio
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final selected = await showDatePicker(
                              context: context,
                              initialDate:
                                  _startDate ??
                                  DateTime.now().subtract(
                                    const Duration(days: 30),
                                  ),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selected != null) {
                              setState(() {
                                _startDate = selected;
                              });
                            }
                          },
                          child: Text(
                            _startDate != null
                                ? 'Inicio: ${_startDate!.toLocal()}'.split(
                                    ' ',
                                  )[0]
                                : 'Seleccionar fecha inicio',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Fecha fin
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final selected = await showDatePicker(
                              context: context,
                              initialDate: _endDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selected != null) {
                              setState(() {
                                _endDate = selected;
                              });
                            }
                          },
                          child: Text(
                            _endDate != null
                                ? 'Fin: ${_endDate!.toLocal()}'.split(' ')[0]
                                : 'Seleccionar fecha fin',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Botón filtrar
                      ElevatedButton(
                        onPressed: () {
                          if (_startDate != null && _endDate != null) {
                            context.read<ProductProfitListBloc>().add(
                              LoadProductProfitListEvent(
                                startDate: _startDate!,
                                endDate: _endDate!,
                              ),
                            );
                          } else {
                            // Opcional: mostrar un mensaje de error
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Selecciona ambas fechas'),
                              ),
                            );
                          }
                        },
                        child: const Text('Filtrar'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.productProfitList.length,
                    itemBuilder: (context, index) {
                      final productProfit = state.productProfitList[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              productProfit.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cantidad vendida: ${productProfit.totalQuantitySold}",
                                ),
                                Text(
                                  "Total ventas: \$${productProfit.totalSales.toStringAsFixed(2)}",
                                ),
                                Text(
                                  "Costo promedio: \$${productProfit.avgCost.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Ganancia",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  "\$${productProfit.profit.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),

                          Divider(
                            color: Colors.grey, // Color de la línea
                            thickness: 0.4, // Grosor de la línea
                            indent: 4, // Espaciado desde la izquierda
                            endIndent: 4, // Espaciado desde la derecha
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is CategoriesListLoadFailure) {
            return const Center(child: Text('Error al cargar compras.'));
          } else {
            return const Center(child: Text('Estado desconocido'));
          }
        },
      ),
    );
  }
}
