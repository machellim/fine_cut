import 'dart:async';

import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/category/search_categories/search_categories_bloc.dart';
import 'package:fine_cut/bloc/product/product_crud/product_crud_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_bool_switch.dart';
import 'package:fine_cut/widgets/app_button.dart';
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
  final TextEditingController _hasSubProductsController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final dropDownKey = GlobalKey<DropdownSearchState>();

  ProductsCompanion productCompanion = ProductsCompanion(); // default values
  List<ProductSubproductsCompanion> productSubproductsCompanions = [];

  List<Product> selectedProducts = [];

  bool isNew = true;
  Category? selectedCategory;

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

    // restart state
    context.read<ProductCrudBloc>().add(ResetProductCrudEvent());

    productCompanion = productCompanion.copyWith(
      hasSubProducts: drift.Value(
        _hasSubProductsController.text.toLowerCase() == 'true',
      ),
    );

    Future.microtask(() {
      if (!mounted) return;
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null) {
        final product = args['product'] as Product;
        final category = args['category'] as Category?;

        productCompanion = productCompanion.copyWith(
          id: drift.Value(product.id),
          categoryId: drift.Value(product.categoryId),
          name: drift.Value(product.name),
          hasSubProducts: drift.Value(product.hasSubProducts),
          status: drift.Value(product.status),
          description: drift.Value(product.description),
        );

        _categoryIdController.text = product.categoryId.toString();
        _productNameController.text = product.name;
        _hasSubProductsController.text = product.hasSubProducts.toString();
        _statusController.text = product.status.name;
        _descriptionController.text = product.description ?? '';

        selectedCategory = category;
        selectedProducts = args['subproducts'];

        // on edit, load existing subproducts
        productSubproductsCompanions = selectedProducts.map((subproduct) {
          return ProductSubproductsCompanion.insert(
            productId: product.id,
            subproductId: subproduct.id,
          );
        }).toList();

        setState(() {
          isNew = false;
        });
      }
    });
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<ProductsListBloc>().add(LoadProductsListEvent(eventSource));
    });
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
          padding: AppConstants.screenPadding,
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
                    selectedItem: selectedCategory,
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

                  if (productCompanion.hasSubProducts.value) ...[
                    const SizedBox(height: 20),
                    DropdownSearch<Product>.multiSelection(
                      items: (filter, loadProps) async {
                        final repo = context.read<ProductsListBloc>();
                        return await repo.productDao.searchProducts(filter);
                      },
                      selectedItems: [...selectedProducts],
                      itemAsString: (item) => item.name,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      onChanged: (selectedProducts) {
                        setState(() {
                          productSubproductsCompanions = selectedProducts.map((
                            subproduct,
                          ) {
                            return ProductSubproductsCompanion.insert(
                              productId: 0,
                              subproductId: subproduct.id,
                            );
                          }).toList();
                        });
                      },
                      /*validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos un subproducto.';
                        }
                        return null;
                      },*/
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Seleccione subproductos',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      popupProps: PopupPropsMultiSelection.menu(
                        showSearchBox: true,
                        constraints: const BoxConstraints(maxHeight: 250),
                        emptyBuilder: (context, searchEntry) {
                          return const Center(
                            child: Text(
                              "No se encontraron productos",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

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
                  BlocConsumer<ProductCrudBloc, ProductCrudState>(
                    listener: (context, state) {
                      if (state is ProductCrudCreationSuccess) {
                        goBack(AppEventSource.create);
                      }
                      if (state is ProductCrudUpdateSuccess) {
                        goBack(AppEventSource.update);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is ProductCrudCreationInProgress;
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
                                            productSubproductsCompanions,
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
