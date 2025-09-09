import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/income/income_crud/income_crud_bloc.dart';
import 'package:fine_cut/bloc/income/income_list/income_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_number_field.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewIncomeScreen extends StatefulWidget {
  const NewIncomeScreen({super.key});

  @override
  State<NewIncomeScreen> createState() => _NewIncomeScreenState();
}

class _NewIncomeScreenState extends State<NewIncomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  IncomesCompanion incomeCompanion = IncomesCompanion();

  bool isNewIncome = true;
  int? cashRegisterId;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final args = ModalRoute.of(context)?.settings.arguments as Map;
      final income = (args['income']) as Income?;
      cashRegisterId = args['cashRegisterId'];

      if (income != null) {
        incomeCompanion = incomeCompanion.copyWith(
          id: drift.Value(income.id),
          amount: drift.Value(income.amount),
          description: drift.Value(income.description),
        );
        _amountController.text = income.amount.toString();
        _descriptionController.text = income.description;
        setState(() {
          isNewIncome = false;
        });
      } else {
        incomeCompanion = incomeCompanion.copyWith(
          cashRegisterId: drift.Value(cashRegisterId),
        );
      }
    });
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<IncomeListBloc>().add(
        LoadIncomesListEvent(eventSource, cashRegisterId!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewIncome
              ? AppMessages.getIncomeMessage('messageNewIncomeScreen')
              : AppMessages.getIncomeMessage('messageEditIncomeScreen'),
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
                          AppTextField(
                            controller: _descriptionController,
                            label: 'Descripción del Ingreso',
                            onSaved: (value) {
                              incomeCompanion = incomeCompanion.copyWith(
                                description: drift.Value(value),
                              );
                            },
                            isMultiline: true,
                          ),
                          const SizedBox(height: 30),
                          AppNumberField(
                            controller: _amountController,
                            label: 'Ingrese la cantidad',
                            onSaved: (value) {
                              incomeCompanion = incomeCompanion.copyWith(
                                amount: drift.Value(double.parse(value)),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          BlocConsumer<IncomeCrudBloc, IncomeCrudState>(
                            listener: (context, state) {
                              if (state is IncomeCreationSuccess) {
                                goBack(AppEventSource.create);
                              }
                              if (state is IncomeUpdateSuccess) {
                                goBack(AppEventSource.update);
                              }
                            },
                            builder: (context, state) {
                              final isLoading =
                                  state is IncomeCreationInProgress;
                              return Column(
                                children: [
                                  if (state is IncomeCreationFailure)
                                    AppMessageType(
                                      message: state.message,
                                      messageType: MessageType.error,
                                    )
                                  else if (state is IncomeUpdateFailure)
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
                                      title: isNewIncome
                                          ? 'Crear Ingreso'
                                          : 'Actualizar Ingreso',
                                      isLoading: isLoading,
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                context
                                                    .read<IncomeCrudBloc>()
                                                    .add(
                                                      CreateIncomeCrudEvent(
                                                        isNewIncome
                                                            ? RecordAction
                                                                  .create
                                                            : RecordAction
                                                                  .update,
                                                        incomeCompanion,
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
