import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_event.dart';
import 'package:fine_cut/bloc/category/category_crud/category_state.dart';
import 'package:fine_cut/bloc/purchase/parent_product_stock/parent_product_stock_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_description_list_item.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_title_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentProductStockListScreen extends StatefulWidget {
  const ParentProductStockListScreen({super.key});

  @override
  State<ParentProductStockListScreen> createState() =>
      _ParentProductStockListScreenState();
}

class _ParentProductStockListScreenState
    extends State<ParentProductStockListScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ParentProductStockBloc>().add(
      LoadParentProductStockListEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Stock de Producto Principal"),
      body: BlocConsumer<ParentProductStockBloc, ParentProductStockState>(
        listener: (context, state) => {
          if (state is ParentProductStockListLoadSuccess) {},
        },
        builder: (context, state) {
          if (state is ParentProductStockListLoading) {
            return AppLoadingScreen(
              message: AppMessages.getPurchaseMessage('messageLoadingPurchase'),
            );
          } else if (state is ParentProductStockListLoadSuccess) {
            if (state.parentProducts.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: AppMessages.getAppMessage('emptyList'),
                  messageType: MessageType.info,
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.parentProducts.length,
                    itemBuilder: (context, index) {
                      final purchase = state.parentProducts[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(purchase.aliasProductName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                purchase.isSoldOut
                                    ? AppBadgeStatus(
                                        text: 'Agotado',
                                        type: BadgeType.warning,
                                      )
                                    : AppBadgeStatus(
                                        text: 'Disponible',
                                        type: BadgeType.success,
                                      ),
                                const SizedBox(width: 8),
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    // aquí luego puedes manejar la acción
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'agotado',
                                      child: Row(
                                        children: [
                                          Icon(
                                            purchase.isSoldOut
                                                ? Icons.check_box
                                                : Icons.block,
                                            color: purchase.isSoldOut
                                                ? Colors.green
                                                : Colors.redAccent,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            purchase.isSoldOut
                                                ? 'Marcar como Disponible'
                                                : 'Marcar como Agotado',
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        context.read<ParentProductStockBloc>().add(
                                          UpdateParentProductIsSoldOutListEvent(
                                            purchase.id,
                                            !purchase.isSoldOut,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
