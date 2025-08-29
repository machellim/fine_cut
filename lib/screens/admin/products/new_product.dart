import 'dart:async';

import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/category/search_categories/search_categories_bloc.dart';
import 'package:fine_cut/bloc/product/product_crud/product_crud_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_bool_switch.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_string_switch.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final _formKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _hasSubProductsController = TextEditingController(
    text: "false",
  );
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final dropDownKey = GlobalKey<DropdownSearchState>();

  ProductsCompanion productCompanion = ProductsCompanion(); // default values
  bool isNew = true;

  @override
  void dispose() {
    _categoryIdController.dispose();
    _productNameController.dispose();
    _hasSubProductsController.dispose();
    _statusController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    context.read<CategoriesListBloc>().add(
      LoadCategoriesListEvent(AppEventSource.list),
    );

    Future.microtask(() {
      if (!mounted) return;
      final args = ModalRoute.of(context)?.settings.arguments as Product?;
      if (args != null) {
        productCompanion = productCompanion.copyWith(
          id: drift.Value(args.id),
          categoryId: drift.Value(args.categoryId),
          name: drift.Value(args.name),
        );
        _categoryIdController.text = args.categoryId.toString();
        _productNameController.text = args.name;
        _hasSubProductsController.text = args.trackStock.toString();
        _statusController.text = args.status.name;
        _descriptionController.text = args.description ?? '';
        setState(() {
          isNew = false;
        });
      }
    });
  }

  void goBack() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
    });
  }

  FutureOr<List<Category>> fetchCategories(
    String filter,
    LoadProps? loadProps,
  ) {
    // Aquí haces la consulta, por ejemplo llamar al Bloc o filtrar localmente
    final filteredCategories = AppDatabase().categoryDao.searchCategories(
      filter,
    );
    return filteredCategories;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          AppMessages.getProductMessage(
            isNew ? 'messageNewProductScreen' : 'messageEditProductScreen',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownSearch<Category>(
                    key: dropDownKey,
                    selectedItem: null,
                    items: (filter, loadProps) async {
                      final repo = context.read<SearchCategoriesBloc>();
                      return await repo.categoryDao.searchCategories(filter);
                    },
                    itemAsString: (item) => item.name,
                    compareFn: (item1, item2) => item1.id == item2.id,
                    onChanged: (selectedCategory) {
                      if (selectedCategory != null) {
                        productCompanion = productCompanion.copyWith(
                          categoryId: drift.Value(selectedCategory.id),
                        );
                      }
                    },
                    validator: (value) => (value == null || value.name.isEmpty)
                        ? 'Seleccione una categoría.'
                        : null,
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        labelText: 'Seleccione una categoría',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      fit: FlexFit.loose,
                      constraints: BoxConstraints(maxHeight: 200),
                      errorBuilder: (context, searchEntry, exception) {
                        return Center(
                          child: Text(
                            exception.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      },
                      emptyBuilder: (context, searchEntry) {
                        return const Center(
                          child: Text(
                            "No se encontraron categorías",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppTextField(
                    controller: _productNameController,
                    label: 'Ingrese el nombre producto:',
                    onSaved: (value) {
                      productCompanion = productCompanion.copyWith(
                        name: drift.Value(value),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  AppBoolSwitch(
                    controller:
                        _hasSubProductsController, // controller con "true" o "false"
                    activeText: 'Tiene Sub-productos',
                    inactiveText: 'No tiene Sub-productos',
                    onChanged: (value) {
                      setState(() {
                        // Guarda directamente como bool en tu companion
                        productCompanion = productCompanion.copyWith(
                          hasSubProducts: drift.Value(value),
                        );
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Descripción',
                    controller: _descriptionController,
                    isMultiline: true,
                    validate: false,
                    onSaved: (value) {
                      productCompanion = productCompanion.copyWith(
                        description: drift.Value(value),
                      );
                    },
                  ),
                  if (!isNew) ...[
                    const SizedBox(height: 20),
                    AppStringSwitch(
                      controller: _statusController,
                      onChanged: (value) {
                        setState(() {
                          productCompanion = productCompanion.copyWith(
                            status: drift.Value(
                              value
                                  ? AppActiveStatus.active
                                  : AppActiveStatus.inactive,
                            ),
                          );
                        });
                      },
                    ),
                  ],
                  BlocBuilder<ProductCrudBloc, ProductCrudState>(
                    builder: (context, state) {
                      bool isLoading = state is ProductCrudCreationInProgress;
                      bool isSuccess = state is ProductCrudCreationSuccess;
                      bool isUpdate = state is ProductCrudUpdateSuccess;
                      if (isSuccess || isUpdate) {
                        goBack();
                      }
                      return Column(
                        children: [
                          if (state is ProductCrudCreationFailure)
                            AppMessageType(
                              message: state.message,
                              messageType: MessageType.error,
                            )
                          else if (state is ProductCrudUpdateFailure)
                            AppMessageType(
                              message: state.message,
                              messageType: MessageType.error,
                            )
                          else
                            Container(),

                          const SizedBox(height: 80),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              title: isNew
                                  ? 'Crear producto'
                                  : 'Actualizar producto',
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        // get data from the dropdown
                                        context.read<ProductCrudBloc>().add(
                                          CreateProductCrudEvent(
                                            isNew
                                                ? RecordAction.create
                                                : RecordAction.update,
                                            productCompanion,
                                          ),
                                        );
                                      }
                                    },
                              isLoading: isLoading,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
