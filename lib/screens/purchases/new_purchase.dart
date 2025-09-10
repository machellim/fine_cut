import 'package:drift/drift.dart' as drift;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_crud/purchase_crud_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_list/purchase_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_number_field.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPurchaseScreen extends StatefulWidget {
  const NewPurchaseScreen({super.key});
  @override
  NewPurchaseScreenState createState() => NewPurchaseScreenState();
}

class NewPurchaseScreenState extends State<NewPurchaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final dropDownProductKey = GlobalKey<DropdownSearchState>();
  final dropDownPMKey = GlobalKey<DropdownSearchState>();

  // controllers
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  PurchasesCompanion purchaseCompanion = PurchasesCompanion();

  bool isNewPurchase = true;
  Product? selectedProduct;
  PaymentMethod? selectedPaymentMethod;
  int? cashRegisterId;

  @override
  void dispose() {
    _quantityController.dispose();
    _totalPriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<PurchaseListBloc>().add(
        LoadPurchasesListEvent(eventSource, cashRegisterId!),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      //final args = ModalRoute.of(context)?.settings.arguments as Purchase?;
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      final purchase = (args['purchase']) as Purchase?;
      selectedProduct = (args['selectedProduct']) as Product?;
      selectedPaymentMethod = (args['selectedPaymentMethod']) as PaymentMethod?;
      cashRegisterId = args['cashRegisterId'];

      if (purchase != null) {
        purchaseCompanion = purchaseCompanion.copyWith(
          id: drift.Value(purchase.id),
          productId: drift.Value(purchase.productId),
          quantity: drift.Value(purchase.quantity),
          totalCost: drift.Value(purchase.totalCost),
        );
        _quantityController.text = purchase.quantity.toString();
        _totalPriceController.text = purchase.totalCost.toString();
        _notesController.text = purchase.notes ?? '';
        setState(() {
          isNewPurchase = false;
        });
      } else {
        purchaseCompanion = purchaseCompanion.copyWith(
          cashRegisterId: drift.Value(cashRegisterId),
        );
        setState(() {
          selectedPaymentMethod =
              (args?['defaultSelectedPaymentMethod']) as PaymentMethod?;
          purchaseCompanion = purchaseCompanion.copyWith(
            paymentMethodId: drift.Value(selectedPaymentMethod?.id ?? 0),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          isNewPurchase
              ? AppMessages.getPurchaseMessage('messageNewPurchaseScreen')
              : AppMessages.getPurchaseMessage('messageEditPurchaseScreen'),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: AppConstants.screenPadding,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownSearch<Product>(
                          key: dropDownProductKey,
                          selectedItem: selectedProduct,
                          items: (filter, loadProps) async {
                            final repo = context.read<ProductsListBloc>();
                            return await repo.productDao.searchProducts(filter);
                          },
                          itemAsString: (item) => item.name,
                          compareFn: (item1, item2) => item1.id == item2.id,
                          onChanged: (selProduct) {
                            if (selProduct != null) {
                              purchaseCompanion = purchaseCompanion.copyWith(
                                productId: drift.Value(selProduct.id),
                              );
                              purchaseCompanion = purchaseCompanion.copyWith(
                                aliasProductName: drift.Value(selProduct.name),
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

                                        if (item.hasSubProducts)
                                          AppBadgeStatus(
                                            text: 'Primario',
                                            type: BadgeType.success,
                                          ),
                                      ],
                                    ),
                                  );
                                },
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        AppNumberField(
                          controller: _quantityController,
                          label: 'Ingrese la cantidad',
                          suffixText: 'unidades / libras',
                          onSaved: (value) {
                            purchaseCompanion = purchaseCompanion.copyWith(
                              quantity: drift.Value(double.parse(value)),
                            );
                          },
                        ),
                        const SizedBox(height: 30.0),
                        AppNumberField(
                          controller: _totalPriceController,
                          label: 'Ingrese el precio de compra',
                          suffixText: '\$ ',
                          onSaved: (value) {
                            purchaseCompanion = purchaseCompanion.copyWith(
                              totalCost: drift.Value(double.parse(value)),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        DropdownSearch<PaymentMethod>(
                          key: dropDownPMKey,
                          selectedItem: selectedPaymentMethod,
                          items: (filter, loadProps) async {
                            final repo = context.read<PaymentMethodListBloc>();
                            return await repo.paymentMethodDao
                                .searchPaymentMethods(filter);
                          },
                          itemAsString: (item) => item.name,
                          compareFn: (item1, item2) => item1.id == item2.id,
                          onChanged: (selectedPaymentMethod) {
                            if (selectedPaymentMethod != null) {
                              purchaseCompanion = purchaseCompanion.copyWith(
                                paymentMethodId: drift.Value(
                                  selectedPaymentMethod.id,
                                ),
                              );
                            }
                          },
                          validator: (value) =>
                              (value == null || value.name.isEmpty)
                              ? 'Seleccione una Forma de Pago.'
                              : null,
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                              labelText: 'Seleccione una Forma de Pago',
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
                                  "No se encontraron Formas de Pago",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Descripción',
                          controller: _notesController,
                          isMultiline: true,
                          validate: false,
                          onSaved: (value) {
                            purchaseCompanion = purchaseCompanion.copyWith(
                              notes: drift.Value(value),
                            );
                          },
                        ),

                        BlocConsumer<PurchaseCrudBloc, PurchaseCrudState>(
                          listener: (context, state) {
                            if (state is PurchaseCreationSuccess) {
                              goBack(AppEventSource.create);
                            }
                            if (state is PurchaseUpdateSuccess) {
                              goBack(AppEventSource.update);
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state is PurchaseCreationInProgress;
                            return Column(
                              children: [
                                if (state is PurchaseCreationFailure)
                                  AppMessageType(
                                    message: state.message,
                                    messageType: MessageType.error,
                                  )
                                else if (state is PurchaseUpdateFailure)
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
                                    title: isNewPurchase
                                        ? 'Crear Compra'
                                        : 'Actualizar Compra',
                                    isLoading: isLoading,
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();

                                              context
                                                  .read<PurchaseCrudBloc>()
                                                  .add(
                                                    CreatePurchaseEvent(
                                                      isNewPurchase
                                                          ? RecordAction.create
                                                          : RecordAction.update,
                                                      purchaseCompanion,
                                                      selectedProduct!,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
