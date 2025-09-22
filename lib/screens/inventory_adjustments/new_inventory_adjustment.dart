import 'package:drift/drift.dart' as drift;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fine_cut/bloc/expense/expense_crud/expense_crud_bloc.dart';
import 'package:fine_cut/bloc/expense/expense_list/expense_list_bloc.dart';
import 'package:fine_cut/bloc/inventory_adjustment/inventory_adjustment_crud/inventory_adjustment_crud_bloc.dart';
import 'package:fine_cut/bloc/inventory_adjustment/inventory_adjustment_list/inventory_adjustment_list_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_number_field.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryAdjustmentScreen extends StatefulWidget {
  const InventoryAdjustmentScreen({super.key});

  @override
  State<InventoryAdjustmentScreen> createState() =>
      _InventoryAdjustmentScreenState();
}

class _InventoryAdjustmentScreenState extends State<InventoryAdjustmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final dropDownProductKey = GlobalKey<DropdownSearchState>();
  final dropDownAdjustmentTypeKey = GlobalKey<DropdownSearchState>();

  // controllers
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  InventoryAdjustmentsCompanion inventoryAdjustmentCompanion =
      InventoryAdjustmentsCompanion();

  bool isNewInventoryAdjustment = true;
  Product? selectedProduct;
  AdjustmentType? selectedAdjustmentType;
  int? cashRegisterId;

  @override
  void dispose() {
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args == null) return;

      final adjustmentMap = args['adjustment'] as Map<String, dynamic>?;
      selectedProduct = (args['selectedProduct']) as Product?;
      selectedAdjustmentType =
          (args['selectedAdjustmentType']) as AdjustmentType?;
      cashRegisterId = args['cashRegisterId'];

      if (adjustmentMap != null) {
        inventoryAdjustmentCompanion = inventoryAdjustmentCompanion.copyWith(
          id: drift.Value(adjustmentMap['id']),
          quantity: drift.Value(adjustmentMap['quantity']),
          description: drift.Value(adjustmentMap['description']),
          adjustmentTypeId: drift.Value(adjustmentMap['adjustmentTypeId']),
          productId: drift.Value(adjustmentMap['productId']),
        );
        _quantityController.text = adjustmentMap['quantity'].toString();
        _descriptionController.text = adjustmentMap['description'] ?? '';
        setState(() {
          isNewInventoryAdjustment = false;
        });
      } else {
        inventoryAdjustmentCompanion = inventoryAdjustmentCompanion.copyWith(
          cashRegisterId: drift.Value(cashRegisterId),
        );
      }
    });
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<InventoryAdjustmentListBloc>().add(
        LoadInventoryAdjustmentListEvent(eventSource, cashRegisterId!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewInventoryAdjustment
              ? AppMessages.getInventoryAdjustmentMessage(
                  'messageNewInventoryAdjustmentScreen',
                )
              : AppMessages.getInventoryAdjustmentMessage(
                  'messageEditInventoryAdjustmentScreen',
                ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: 80.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownSearch<AdjustmentType>(
                            key: dropDownAdjustmentTypeKey,
                            selectedItem: selectedAdjustmentType,
                            items: (filter, loadProps) async {
                              final repo = context
                                  .read<InventoryAdjustmentListBloc>();
                              return await repo.inventoryAdjustmentDao
                                  .searchAdjustmentTypes(filter);
                            },
                            itemAsString: (item) => item.name,
                            compareFn: (item1, item2) => item1.id == item2.id,
                            onChanged: (selAdjustmentType) {
                              if (selAdjustmentType != null) {
                                inventoryAdjustmentCompanion =
                                    inventoryAdjustmentCompanion.copyWith(
                                      adjustmentTypeId: drift.Value(
                                        selAdjustmentType.id,
                                      ),
                                    );
                                selectedAdjustmentType = selAdjustmentType;
                              }
                            },
                            validator: (value) =>
                                (value == null || value.name.isEmpty)
                                ? 'Seleccione un tipo de ajuste.'
                                : null,
                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Seleccione un tipo de ajuste',
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
                              itemBuilder:
                                  (context, item, isDisabled, isSelected) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      color: isSelected
                                          ? theme.colorScheme.primary.withAlpha(
                                              (0.2 * 255).round(),
                                            )
                                          : null, // resaltar el item seleccionado
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),

                                          if (item.increasesStock)
                                            AppBadgeStatus(
                                              text: '(+) Aumenta stock',
                                              type: BadgeType.success,
                                              textStyle:
                                                  theme.textTheme.bodyMedium,
                                            ),
                                          if (!item.increasesStock)
                                            AppBadgeStatus(
                                              text: '(-) Disminuye stock',
                                              type: BadgeType.warning,
                                              textStyle:
                                                  theme.textTheme.bodyMedium,
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                            ),
                          ),
                          const SizedBox(height: 30),
                          DropdownSearch<Product>(
                            key: dropDownProductKey,
                            selectedItem: selectedProduct,
                            items: (filter, loadProps) async {
                              final repo = context.read<ProductsListBloc>();
                              return await repo.productDao.searchSubProducts(
                                filter,
                              );
                            },
                            itemAsString: (item) => item.name,
                            compareFn: (item1, item2) => item1.id == item2.id,
                            onChanged: (selProduct) {
                              if (selProduct != null) {
                                inventoryAdjustmentCompanion =
                                    inventoryAdjustmentCompanion.copyWith(
                                      productId: drift.Value(selProduct.id),
                                    );
                                selectedProduct = selProduct;
                              }
                            },
                            validator: (value) =>
                                (value == null || value.name.isEmpty)
                                ? 'Seleccione un producto.'
                                : null,
                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Seleccione un producto',
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
                                    "No se encontraron productos",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                );
                              },
                              itemBuilder:
                                  (context, item, isDisabled, isSelected) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      color: isSelected
                                          ? theme.colorScheme.primary.withAlpha(
                                              (0.2 * 255).round(),
                                            )
                                          : null, // resaltar el item seleccionado
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),

                                          AppBadgeStatus(
                                            text: 'Stock actual: ${item.stock}',
                                            type: BadgeType.info,
                                            textStyle:
                                                theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                            ),
                          ),
                          const SizedBox(height: 30),
                          AppNumberField(
                            controller: _quantityController,
                            label: 'Ingrese la cantidad',
                            onSaved: (value) {
                              inventoryAdjustmentCompanion =
                                  inventoryAdjustmentCompanion.copyWith(
                                    quantity: drift.Value(double.parse(value)),
                                  );
                            },
                          ),
                          const SizedBox(height: 30),
                          AppTextField(
                            controller: _descriptionController,
                            label: 'Descripción del ajuste',
                            onSaved: (value) {
                              inventoryAdjustmentCompanion =
                                  inventoryAdjustmentCompanion.copyWith(
                                    description: drift.Value(value),
                                  );
                            },
                            isMultiline: true,
                            validate: false,
                          ),
                          const SizedBox(height: 30),
                          BlocConsumer<
                            InventoryAdjustmentCrudBloc,
                            InventoryAdjustmentCrudState
                          >(
                            listener: (context, state) {
                              if (state is InventoryAdjustmentCreationSuccess) {
                                goBack(AppEventSource.create);
                              }
                              if (state is InventoryAdjustmentUpdateSuccess) {
                                goBack(AppEventSource.update);
                              }
                            },
                            builder: (context, state) {
                              final isLoading =
                                  state
                                      is InventoryAdjustmentCreationInProgress;
                              return Column(
                                children: [
                                  if (state
                                      is InventoryAdjustmentCreationFailure)
                                    AppMessageType(
                                      message: state.message,
                                      messageType: MessageType.error,
                                    )
                                  else if (state
                                      is InventoryAdjustmentUpdateFailure)
                                    AppMessageType(
                                      message: state.message,
                                      messageType: MessageType.error,
                                    )
                                  else
                                    Container(),

                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: double.infinity,
                                    child: AppButton(
                                      title: isNewInventoryAdjustment
                                          ? 'Crear Ajuste'
                                          : 'Actualizar Ajuste',
                                      isLoading: isLoading,
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                context
                                                    .read<
                                                      InventoryAdjustmentCrudBloc
                                                    >()
                                                    .add(
                                                      CreateInventoryAdjustmentCrudEvent(
                                                        isNewInventoryAdjustment
                                                            ? RecordAction
                                                                  .create
                                                            : RecordAction
                                                                  .update,
                                                        inventoryAdjustmentCompanion,
                                                      ),
                                                    );
                                              }
                                            },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
