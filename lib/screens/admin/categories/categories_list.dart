import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_event.dart';
import 'package:fine_cut/bloc/category/category_crud/category_state.dart';
import 'package:fine_cut/constants/app_messages.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_description_list_item.dart';
import 'package:fine_cut/widgets/app_floating_action_button.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_title_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  @override
  void initState() {
    super.initState();
    // Disparar el evento para cargar las categorías cuando se abre la pantalla
    context.read<CategoriesListBloc>().add(LoadCategoriesListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Lista de Categorías"),
      body: BlocBuilder<CategoriesListBloc, CategoriesListState>(
        builder: (context, state) {
          if (state is CategoriesListLoading) {
            return AppLoadingScreen(
              message: AppMessages.getCategoryMessage(
                'messageLoadingCategories',
              ),
            );
          } else if (state is CategoriesListLoadSuccess) {
            if (state.categories.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: 'No hay categorías disponibles.',
                  messageType: MessageType.info,
                ),
              );
            }
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    AppListItem(
                      title: AppTitleListItem(
                        text: state.categories[index].name,
                        status: state.categories[index].status.name,
                      ),
                      description: state.categories[index].description != null
                          ? AppDescriptionListItem(
                              text: state.categories[index].description!,
                              status: state.categories[index].status.name,
                            )
                          : null, // Flutter ignora la propiedad si es null
                      onEdit: () {
                        Navigator.pushNamed(
                          context,
                          'new-category',
                          arguments: state.categories[index],
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
          } else if (state is CategoriesListLoadFailure) {
            return const Center(child: Text('Error al cargar categorías'));
          } else {
            return const Center(child: Text('Estado desconocido'));
          }
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'new-category');
        },
        tooltip: 'Agregar Categoría',
        icon: Icons.add,
      ),
    );
  }
}
