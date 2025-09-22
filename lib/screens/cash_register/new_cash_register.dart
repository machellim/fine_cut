import 'package:fine_cut/bloc/cash_register/cash_register_crud/cash_register_crud_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_data/cash_register_data_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_date_field.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';

import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCashRegisterScreen extends StatefulWidget {
  const NewCashRegisterScreen({super.key});

  @override
  State<NewCashRegisterScreen> createState() => _NewCashRegisterScreenState();
}

class _NewCashRegisterScreenState extends State<NewCashRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _registerDateController;
  final _notesController = TextEditingController();
  final _openingAmountController = TextEditingController();

  bool isNew = true;

  @override
  void dispose() {
    _registerDateController.dispose();
    _openingAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _registerDateController = TextEditingController();

    context.read<CashRegisterDataBloc>().add(LoadDataCashRegisterEvent());
  }

  void goBack() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarCustom(title: isNew ? 'Crear Nueva Caja' : 'Editar Caja'),
      body: BlocBuilder<CashRegisterDataBloc, CashRegisterDataState>(
        builder: (context, state) {
          if (state is DataCashRegisterLoading) {
            return AppLoadingScreen(
              message: AppMessages.getCashRegistersMessage(
                'messageLoadingDataCashRegisters',
              ),
            );
          } else if (state is DataCashRegisterLoadSuccess) {
            final lastClosingAmount = state.lastClosingAmount;
            final nextRegisterDate = state.nextRegisterDate;
            _openingAmountController.text = AppUtils.formatDouble(
              lastClosingAmount,
            );
            _registerDateController.text = AppUtils.formatDate(
              nextRegisterDate,
            );
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Icon(
                          Icons.point_of_sale,
                          size: 64,
                          color: Theme.of(context).colorScheme.primary,
                        ),

                        const SizedBox(height: 30),
                        AppDateField(
                          label: "Fecha de la caja",
                          controller: _registerDateController,
                          //initialDate: nextRegisterDate,
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 30),
                          ),
                          lastDate: DateTime.now(),
                          onDateSelected: (date) {
                            _registerDateController.text = AppUtils.formatDate(
                              date,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Saldo Inicial',
                          initialValue: AppUtils.formatDouble(
                            lastClosingAmount,
                          ),
                          controller: _openingAmountController,
                          suffixIcon: Icons.monetization_on_outlined,
                          readOnly: true,
                          //enabled: false,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please enter your username'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Notas',
                          autofocus: true,
                          controller: _notesController,
                          isMultiline: true,
                          validate: false,
                        ),
                        const SizedBox(height: 20),
                        BlocConsumer<
                          CashRegisterCrudBloc,
                          CashRegisterCrudState
                        >(
                          listener: (context, state) {
                            if (state is CreateCashRegisterSuccess) {
                              final cashRegister =
                                  state.cashRegisterResult!.cashRegister;
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'view-edit-cash-register',
                                (route) => false,
                                arguments: {'cashRegister': cashRegister},
                              );
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state is CreateCashRegisterLoading;
                            final errorFailure =
                                state is CreateCashRegisterFailure
                                ? state.message
                                : null;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppButton(
                                  title: isLoading
                                      ? 'Creando Caja...'
                                      : (isNew
                                            ? 'Crear Caja'
                                            : 'Actualizar Caja'),
                                  isLoading: isLoading,
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            context
                                                .read<CashRegisterCrudBloc>()
                                                .add(
                                                  CreateCashRegisterEvent(
                                                    registerDate:
                                                        _registerDateController
                                                            .text,
                                                    openingAmount: double.parse(
                                                      _openingAmountController
                                                          .text,
                                                    ),
                                                    notes:
                                                        _notesController.text,
                                                  ),
                                                );
                                          }
                                        },
                                ),
                                if (errorFailure != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: AppMessageType(
                                      message: errorFailure,
                                      messageType: MessageType.error,
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
            );
          } else if (state is DataCashRegisterLoadFailure) {
            return Center(
              child: Text(
                AppMessages.getCashRegistersMessage(
                  'messageLoadFailureDataCashRegisters',
                ),
              ),
            );
          } else {
            return Center(child: Text('Estado desconocido'));
          }
        },
      ),
    );
  }
}
