import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/expense/expense_crud/expense_crud_bloc.dart';
import 'package:fine_cut/bloc/expense/expense_list/expense_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_number_field.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  ExpensesCompanion expenseCompanion = ExpensesCompanion();

  bool isNewExpense = true;
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
      final expense = (args['expense']) as Expense?;
      cashRegisterId = args['cashRegisterId'];

      if (expense != null) {
        expenseCompanion = expenseCompanion.copyWith(
          id: drift.Value(expense.id),
          amount: drift.Value(expense.amount),
          description: drift.Value(expense.description),
        );
        _amountController.text = expense.amount.toString();
        _descriptionController.text = expense.description;
        setState(() {
          isNewExpense = false;
        });
      } else {
        expenseCompanion = expenseCompanion.copyWith(
          cashRegisterId: drift.Value(cashRegisterId),
        );
      }
    });
  }

  void goBack(AppEventSource eventSource) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context, true);
      context.read<ExpenseListBloc>().add(
        LoadExpensesListEvent(eventSource, cashRegisterId!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewExpense
              ? AppMessages.getExpenseMessage('messageNewExpenseScreen')
              : AppMessages.getExpenseMessage('messageEditExpenseScreen'),
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
                            label: 'Descripción del Gasto',
                            onSaved: (value) {
                              expenseCompanion = expenseCompanion.copyWith(
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
                              expenseCompanion = expenseCompanion.copyWith(
                                amount: drift.Value(double.parse(value)),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          BlocConsumer<ExpenseCrudBloc, ExpenseCrudState>(
                            listener: (context, state) {
                              if (state is ExpenseCreationSuccess) {
                                goBack(AppEventSource.create);
                              }
                              if (state is ExpenseUpdateSuccess) {
                                goBack(AppEventSource.update);
                              }
                            },
                            builder: (context, state) {
                              final isLoading =
                                  state is ExpenseCreationInProgress;
                              return Column(
                                children: [
                                  if (state is ExpenseCreationFailure)
                                    AppMessageType(
                                      message: state.message,
                                      messageType: MessageType.error,
                                    )
                                  else if (state is ExpenseUpdateFailure)
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
                                      title: isNewExpense
                                          ? 'Crear Gasto'
                                          : 'Actualizar Gasto',
                                      isLoading: isLoading,
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                context
                                                    .read<ExpenseCrudBloc>()
                                                    .add(
                                                      CreateExpenseCrudEvent(
                                                        isNewExpense
                                                            ? RecordAction
                                                                  .create
                                                            : RecordAction
                                                                  .update,
                                                        expenseCompanion,
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
