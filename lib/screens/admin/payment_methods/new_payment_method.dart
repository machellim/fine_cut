import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_event.dart';
import 'package:fine_cut/bloc/category/category_crud/category_state.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_crud/payment_method_crud_bloc.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_int_field.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_string_switch.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPaymentMethodScreen extends StatefulWidget {
  const NewPaymentMethodScreen({super.key});

  @override
  State<NewPaymentMethodScreen> createState() => _NewPaymentMethodScreenState();
}

class _NewPaymentMethodScreenState extends State<NewPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _displayOrder = TextEditingController();
  final _statusController = TextEditingController();

  bool isNew = true;
  PaymentMethodsCompanion paymentMethodCompanion = PaymentMethodsCompanion();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    _displayOrder.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // restart state
    context.read<PaymentMethodCrudBloc>().add(ResetPaymentMethodCrudEvent());

    Future.microtask(() {
      final args = ModalRoute.of(context)?.settings.arguments as PaymentMethod?;

      if (args != null) {
        paymentMethodCompanion = PaymentMethodsCompanion(
          id: drift.Value(args.id),
          name: drift.Value(args.name),
          displayOrder: drift.Value(args.displayOrder),
          description: drift.Value(args.description),
          status: drift.Value(args.status),
        );
        _nameController.text = args.name.toString();
        _descriptionController.text = args.description ?? '';
        _displayOrder.text = args.displayOrder.toString();
        _statusController.text = args.status.name;
        setState(() {
          isNew = false;
        });
      }
    });
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<PaymentMethodListBloc>().add(
        LoadPaymentMethodsEvent(eventSource),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Nueva Forma de Pago' : 'Editar Forma de Pago'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: AppConstants.screenPadding,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: 'Nombre Forma de Pago',
                    onSaved: (value) {
                      paymentMethodCompanion = paymentMethodCompanion.copyWith(
                        name: drift.Value(value),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AppIntField(
                    label: 'Orden',
                    controller: _displayOrder,
                    onSaved: (value) => {
                      paymentMethodCompanion = paymentMethodCompanion.copyWith(
                        displayOrder: drift.Value(int.parse(value)),
                      ),
                    },
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Descripción',
                    controller: _descriptionController,
                    isMultiline: true,
                    validate: false,
                    onSaved: (value) {
                      paymentMethodCompanion = paymentMethodCompanion.copyWith(
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
                          paymentMethodCompanion = paymentMethodCompanion
                              .copyWith(
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

                  const SizedBox(height: 40),
                  BlocConsumer<PaymentMethodCrudBloc, PaymentMethodCrudState>(
                    listener: (context, state) {
                      if (state is PaymentMethodCreationSuccess) {
                        goBack(AppEventSource.create);
                      }
                      if (state is PaymentMethodUpdateSuccess) {
                        goBack(AppEventSource.update);
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state is PaymentMethodCreationInProgress;
                      return Column(
                        children: [
                          if (state is PaymentMethodCreationFailure)
                            AppMessageType(
                              message: state.message,
                              messageType: MessageType.error,
                            ),
                          if (state is PaymentMethodUpdateFailure)
                            AppMessageType(
                              message: state.message,
                              messageType: MessageType.error,
                            ),

                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              title: isNew
                                  ? 'Crear Forma de Pago'
                                  : 'Actualizar Forma de Pago',
                              isLoading: isLoading,
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        context
                                            .read<PaymentMethodCrudBloc>()
                                            .add(
                                              CreatePaymentMethodEvent(
                                                isNew ? 'create' : 'update',
                                                paymentMethodCompanion,
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
    );
  }
}
