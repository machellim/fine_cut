import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_button.dart';
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

  // controllers
  final TextEditingController _saleQuantityController = TextEditingController();
  final TextEditingController _saleTotalPriceController =
      TextEditingController();

  final dropDownKey = GlobalKey<DropdownSearchState>();
  final fpDropDownKey = GlobalKey<DropdownSearchState>();

  SalesCompanion saleCompanion = SalesCompanion();
  //PaymentMethod? selectedPaymentMethod;
  bool isNewSale = true;

  @override
  void dispose() {
    _saleQuantityController.dispose();
    _saleTotalPriceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      final args = ModalRoute.of(context)?.settings.arguments as Sale?;

      if (args != null) {
        saleCompanion = saleCompanion.copyWith(
          id: drift.Value(args.id),
          productId: drift.Value(args.productId),
          quantity: drift.Value(args.quantity),
          totalPrice: drift.Value(args.totalPrice),
        );
        _saleQuantityController.text = args.quantity.toString();
        _saleTotalPriceController.text = args.totalPrice.toString();
        setState(() {
          isNewSale = false;
        });
      }
    });
  }

  void goBack() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('oo')),
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
                          key: dropDownKey,
                          selectedItem: null,
                          items: (filter, loadProps) async {
                            final repo = context.read<ProductsListBloc>();
                            return await repo.productDao.searchProducts(filter);
                          },
                          itemAsString: (item) => item.name,
                          compareFn: (item1, item2) => item1.id == item2.id,
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
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        AppNumberField(
                          controller: _saleQuantityController,
                          label: 'Ingrese la cantidad',
                          suffixText: 'unidades / libras',
                          onSaved: (value) {
                            saleCompanion = saleCompanion.copyWith(
                              quantity: drift.Value(double.parse(value)),
                            );
                          },
                        ),
                        const SizedBox(height: 30.0),
                        AppNumberField(
                          controller: _saleTotalPriceController,
                          label: 'Ingrese el precio de venta',
                          prefixText: '\$ ',
                          onSaved: (value) {
                            saleCompanion = saleCompanion.copyWith(
                              totalPrice: drift.Value(double.parse(value)),
                            );
                          },
                        ),
                        const SizedBox(height: 30.0),
                        DropdownSearch<PaymentMethod>(
                          key: fpDropDownKey,
                          selectedItem: null,
                          items: (filter, loadProps) async {
                            final repo = context.read<PaymentMethodListBloc>();
                            return await repo.paymentMethodDao
                                .searchPaymentMethods(filter);
                          },
                          itemAsString: (item) => item.name,
                          compareFn: (item1, item2) => item1.id == item2.id,
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
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            title: isNewSale
                                ? 'Crear Venta'
                                : 'Actualizar Venta',
                            onPressed: () {},
                          ),
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
