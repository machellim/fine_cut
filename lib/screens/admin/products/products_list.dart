import 'package:fine_cut/bloc/category/search_categories/search_categories_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_floating_action_button.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_title_list_item.dart';
import 'package:fine_cut/widgets/app_top_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  bool _showBanner = false;
  String _bannerMessage = '';

  @override
  void initState() {
    super.initState();
    // Disparar el evento para cargar las categorías cuando se abre la pantalla
    context.read<ProductsListBloc>().add(
      LoadProductsListEvent(AppEventSource.list),
    );
  }

  void _showTopBanner(String message) {
    setState(() {
      _showBanner = true;
      _bannerMessage = message;
    });
  }

  void _closeBanner() {
    setState(() {
      _showBanner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catálogo de Productos")),
      body: BlocConsumer<ProductsListBloc, ProductsListState>(
        listener: (context, state) => {
          if (state is ProductsListLoadSuccess)
            {
              if (state.eventSource == AppEventSource.create)
                {_showTopBanner('Producto creado con éxito')}
              else if (state.eventSource == AppEventSource.update)
                {_showTopBanner('Producto actualizado con éxito')},
            },
        },
        builder: (context, state) {
          if (state is ProductsListLoading) {
            return Center(
              child: AppCircularProgressText(
                messageLoading: AppMessages.getProductMessage(
                  'messageLoadingProducts',
                ),
              ),
            );
          } else if (state is ProductsListLoadSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: AppMessages.getAppMessage('emptyList'),
                  messageType: MessageType.info,
                ),
              );
            } else {
              return Column(
                children: [
                  if (_showBanner)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppTopBanner(
                        message: _bannerMessage,
                        type: AppBannerType.success,
                        onClose: _closeBanner,
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        final productName = product.name;
                        return Column(
                          children: [
                            AppListItem(
                              title: Row(
                                children: [
                                  AppTitleListItem(
                                    text: productName,
                                    status: product.status.name,
                                  ),
                                  SizedBox(width: 4),
                                  if (product.hasSubProducts)
                                    AppBadgeStatus(
                                      text: 'Primario',
                                      type: BadgeType.success,
                                    ),
                                ],
                              ),
                              /*description: Text(
                                "Stock: $productStock",
                                style: TextStyle(
                                  color: productStock <= 0
                                      ? Colors.red
                                      : Colors
                                            .green, // Cambia el color dependiendo del valor
                                ),
                              ),*/
                              onEdit: () async {
                                // Obtener la categoría completa antes de abrir la pantalla
                                final repoCategory = context
                                    .read<SearchCategoriesBloc>();
                                final repoProduct = context
                                    .read<ProductsListBloc>();

                                final category = await repoCategory.categoryDao
                                    .getById(product.categoryId);

                                // suproducts
                                final subproducts = await repoProduct.productDao
                                    .getSubproductsByProduct(product);

                                // Pasar el producto y la categoría completa como argumento
                                Navigator.pushNamed(
                                  context,
                                  'new-product',
                                  arguments: {
                                    'product': product,
                                    'category': category,
                                    'subproducts': subproducts,
                                  },
                                );
                              },
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
            }
          } else if (state is ProductsListLoadFailure) {
            return const Center(child: Text('Error al cargar los productos'));
          } else {
            return const Center(child: Text('Estado desconocido'));
          }
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'new-product');
        },
        tooltip: 'Agregar Producto',
        icon: Icons.add,
      ),
    );
  }
}
