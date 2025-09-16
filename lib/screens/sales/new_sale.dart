import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_crud/sale_crud_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_list/sale_list_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_parent_product/sale_parent_product_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_number_field.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});
  @override
  NewSaleScreenState createState() => NewSaleScreenState();
}

class NewSaleScreenState extends State<NewSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final dropDownProductKey = GlobalKey<DropdownSearchState>();
  final dropDownPMKey = GlobalKey<DropdownSearchState>();
  final dropDownParentProductKey = GlobalKey<DropdownSearchState>();

  // controllers
  final TextEditingController _saleQuantityController = TextEditingController();
  final TextEditingController _saleTotalPriceController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  SalesCompanion saleCompanion = SalesCompanion();

  bool isNewSale = true;
  Product? selectedProduct;
  PaymentMethod? selectedPaymentMethod;
  Purchase? selectedPurchase;
  int? cashRegisterId;

  @override
  void dispose() {
    _saleQuantityController.dispose();
    _saleTotalPriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // restart state
    context.read<SaleCrudBloc>().add(ResetSaleEvent());

    Future.microtask(() {
      if (!mounted) return;
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      final sale = (args['sale']) as Sale?;
      selectedProduct = (args['selectedProduct']) as Product?;
      selectedPaymentMethod = (args['selectedPaymentMethod']) as PaymentMethod?;
      selectedPurchase = (args['selectedPurchase']) as Purchase?;
      cashRegisterId = args['cashRegisterId'];

      // trigger evento to Parent Product when is edit
      if (selectedProduct != null) {
        context.read<SaleParentProductBloc>().add(
          GetParentProductEvent(selectedProduct!),
        );
      }

      if (sale != null) {
        saleCompanion = saleCompanion.copyWith(
          id: drift.Value(sale.id),
          productId: drift.Value(sale.productId),
          quantity: drift.Value(sale.quantity),
          totalPrice: drift.Value(sale.totalPrice),
        );
        _saleQuantityController.text = sale.quantity.toString();
        _saleTotalPriceController.text = sale.totalPrice.toString();
        _notesController.text = sale.notes ?? '';

        setState(() {
          isNewSale = false;
        });
      } else {
        saleCompanion = saleCompanion.copyWith(
          cashRegisterId: drift.Value(cashRegisterId),
        );
        setState(() {
          selectedPaymentMethod =
              (args?['defaultSelectedPaymentMethod']) as PaymentMethod?;
          saleCompanion = saleCompanion.copyWith(
            paymentMethodId: drift.Value(selectedPaymentMethod?.id ?? 0),
          );
        });
      }
    });
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<SaleListBloc>().add(
        LoadSalesListEvent(eventSource, cashRegisterId!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          isNewSale
              ? AppMessages.getSaleMessage('messageNewSaleScreen')
              : AppMessages.getSaleMessage('messageEditSaleScreen'),
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
                            return await repo.productDao.searchSubProducts(
                              filter,
                            );
                          },
                          itemAsString: (item) => item.name,
                          compareFn: (item1, item2) => item1.id == item2.id,
                          onChanged: (selProduct) {
                            if (selProduct != null) {
                              saleCompanion = saleCompanion.copyWith(
                                productId: drift.Value(selProduct.id),
                              );
                              selectedProduct = selProduct;
                              selectedPurchase = null;

                              context.read<SaleParentProductBloc>().add(
                                GetParentProductEvent(selectedProduct!),
                              );
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
                        // Parent Product
                        BlocConsumer<
                          SaleParentProductBloc,
                          SaleParentProductState
                        >(
                          listener: (context, state) => {
                            if (state is SaleParentProductInitial)
                              {
                                saleCompanion = saleCompanion.copyWith(
                                  purchaseId: drift.Value(null),
                                ),
                              },
                          },
                          builder: (context, state) {
                            if (state is GetParentProductLoading) {
                              return AppCircularProgressText(
                                messageLoading: 'Cargando productos padre.',
                              );
                            } else if (state is GetParentProductSuccess) {
                              final subproductId = state.subproductId;
                              return Column(
                                children: [
                                  const SizedBox(height: 30.0),
                                  DropdownSearch<Purchase>(
                                    key: dropDownParentProductKey,
                                    selectedItem: selectedPurchase,
                                    items: (filter, loadProps) async {
                                      final repo = context.read<SaleListBloc>();
                                      return await repo.saleDao
                                          .getPurchasesSubproduct(
                                            subproductId,
                                            filter: filter,
                                          );
                                    },

                                    itemAsString: (item) =>
                                        item.aliasProductName,
                                    compareFn: (item1, item2) =>
                                        item1.id == item2.id,
                                    onChanged: (selPurchase) {
                                      //if (selPurchase != null) {
                                      saleCompanion = saleCompanion.copyWith(
                                        purchaseId: drift.Value(
                                          selPurchase?.id,
                                        ),
                                      );
                                      selectedPurchase = selPurchase;
                                      //}
                                    },
                                    validator: (value) =>
                                        (value == null ||
                                            value.aliasProductName.isEmpty)
                                        ? 'Seleccione el producto principal.'
                                        : null,
                                    decoratorProps: DropDownDecoratorProps(
                                      decoration: InputDecoration(
                                        labelText:
                                            '🛍️ Elija un producto principal',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    popupProps: PopupProps.menu(
                                      showSearchBox: true,
                                      fit: FlexFit.loose,
                                      constraints: BoxConstraints(
                                        maxHeight: 200,
                                      ),

                                      errorBuilder:
                                          (context, searchEntry, exception) {
                                            return Center(
                                              child: Text(
                                                exception.toString(),
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            );
                                          },
                                      emptyBuilder: (context, searchEntry) {
                                        return const Center(
                                          child: Text(
                                            "No se encontraron productos",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is GetParentProductFailure) {
                              return Center(child: Text(state.message));
                            } else {
                              return Center();
                            }
                          },
                        ),
                        const SizedBox(height: 30.0),
                        AppNumberField(
                          controller: _saleQuantityController,
                          label: 'Ingrese la cantidad',
                          suffixText: 'unidades / libras',
                          onChanged: (value) {
                            // recalcula el total en tiempo real
                            final quantity = double.tryParse(value) ?? 0.0;
                            final unitPrice = selectedProduct?.salePrice ?? 0.0;
                            final totalPrice = quantity * unitPrice;
                            _saleTotalPriceController.text =
                                AppUtils.formatDouble(totalPrice);
                            setState(() {});
                          },
                          onSaved: (value) {
                            // guarda el valor final en el companion
                            final quantity = double.tryParse(value) ?? 0.0;
                            final totalPrice =
                                quantity * (selectedProduct?.salePrice ?? 0.0);
                            saleCompanion = saleCompanion.copyWith(
                              quantity: drift.Value(quantity),
                              totalPrice: drift.Value(totalPrice),
                            );
                          },
                        ),
                        const SizedBox(height: 30.0),
                        AppNumberField(
                          controller: _saleTotalPriceController,
                          label: 'Ingrese el precio de venta',
                          suffixIcon: Icons.monetization_on_outlined,
                          onSaved: (value) {
                            final total = double.tryParse(value) ?? 0.0;
                            saleCompanion = saleCompanion.copyWith(
                              totalPrice: drift.Value(total),
                            );
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 30.0),
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
                              saleCompanion = saleCompanion.copyWith(
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
                        const SizedBox(height: 30),
                        BlocConsumer<SaleCrudBloc, SaleCrudState>(
                          listener: (context, state) {
                            if (state is SaleCreationSuccess) {
                              goBack(AppEventSource.create);
                            }
                            if (state is SaleUpdateSuccess) {
                              goBack(AppEventSource.update);
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is SaleCreationInProgress;
                            return Column(
                              children: [
                                if (state is SaleCreationFailure)
                                  AppMessageType(
                                    message: state.message,
                                    messageType: MessageType.error,
                                  )
                                else if (state is SaleUpdateFailure)
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
                                    title: isNewSale
                                        ? 'Crear Venta'
                                        : 'Actualizar Venta',
                                    isLoading: isLoading,
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();

                                              context.read<SaleCrudBloc>().add(
                                                CreateSaleEvent(
                                                  isNewSale
                                                      ? RecordAction.create
                                                      : RecordAction.update,
                                                  saleCompanion,
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
