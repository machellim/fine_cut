import 'package:drift/drift.dart' as drift;
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

  SalesCompanion sale = SalesCompanion();
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
        sale = sale.copyWith(
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
                          const SizedBox(height: 30.0),
                          AppNumberField(
                            controller: _saleQuantityController,
                            label: 'Ingrese la cantidad',
                            onSaved: (value) {
                              sale = sale.copyWith(
                                quantity: drift.Value(double.parse(value)),
                              );
                            },
                          ),
                          const SizedBox(height: 30.0),
                          AppNumberField(
                            controller: _saleTotalPriceController,
                            label: 'Ingrese el precio de venta',
                            onSaved: (value) {
                              sale = sale.copyWith(
                                totalPrice: drift.Value(double.parse(value)),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          AppButton(
                            title: isNewSale
                                ? 'Crear Venta'
                                : 'Actualizar Venta',
                            onPressed: () {},
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
