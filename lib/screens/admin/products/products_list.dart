import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    super.initState();
    // Disparar el evento para cargar las categorías cuando se abre la pantalla
    context.read<ProductsListBloc>().add(
      LoadProductsListEvent(AppEventSource.list),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catálogo de Productos")),
      body: BlocBuilder<ProductsListBloc, ProductsListState>(
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
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final productName = state.products[index].name;
                  final productStock = state.products[index].stock;
                  return Column(
                    children: [
                      AppListItem(
                        title: Text(productName),
                        description: Text(
                          "Stock: $productStock",
                          style: TextStyle(
                            color: productStock <= 0
                                ? Colors.red
                                : Colors
                                      .green, // Cambia el color dependiendo del valor
                          ),
                        ),
                        onEdit: () {
                          Navigator.pushNamed(
                            context,
                            'new-product',
                            arguments: state.products[index],
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
              );
            }
          } else if (state is ProductsListLoadFailure) {
            return const Center(child: Text('Error al cargar los productos'));
          } else {
            return const Center(child: Text('Estado desconocido'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'new-product');
        },
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: "Agregar producto",
        child: const Icon(Icons.add),
      ),
    );
  }
}
