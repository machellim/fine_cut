import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/product/product_crud/product_crud_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
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
  //final AppDatabase database;
  final _formKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();

  final dropDownKey = GlobalKey<DropdownSearchState>();

  ProductsCompanion product = ProductsCompanion(); // default values
  bool isNew = true;

  @override
  void dispose() {
    _categoryIdController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      final args = ModalRoute.of(context)?.settings.arguments as Product?;
      if (args != null) {
        product = product.copyWith(
          id: drift.Value(args.id),
          categoryId: drift.Value(args.categoryId),
          name: drift.Value(args.name),
        );
        _categoryIdController.text = args.categoryId.toString();
        _productNameController.text = args.name;
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

  @override
  Widget build(BuildContext context) {
    //final categoryDao = database.categoryDao;
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
                          const SizedBox(height: 30),
                          AppTextField(
                            controller: _productNameController,
                            label: 'Ingrese el nombre producto:',
                            onSaved: (value) {
                              product = product.copyWith(
                                name: drift.Value(value),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          BlocBuilder<ProductCrudBloc, ProductCrudState>(
                            builder: (context, state) {
                              bool isLoading =
                                  state is ProductCrudCreationInProgress;
                              bool isSuccess =
                                  state is ProductCrudCreationSuccess;
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
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                // get data from the dropdown
                                                context
                                                    .read<ProductCrudBloc>()
                                                    .add(
                                                      CreateProductCrudEvent(
                                                        isNew
                                                            ? RecordAction
                                                                  .create
                                                            : RecordAction
                                                                  .update,
                                                        product,
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
