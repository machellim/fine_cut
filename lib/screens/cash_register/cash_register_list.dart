import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/cash_register/cash_register_crud/cash_register_crud_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_data/cash_register_data_bloc.dart';
import 'package:fine_cut/constants/app_messages.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:intl/intl.dart';

import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashRegisterListScreen extends StatefulWidget {
  const CashRegisterListScreen({super.key});

  @override
  State<CashRegisterListScreen> createState() => _CashRegisterListScreenState();
}

class _CashRegisterListScreenState extends State<CashRegisterListScreen> {
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
    final String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _registerDateController = TextEditingController(text: today);

    context.read<CashRegisterBloc>().add(LoadDataCashRegisterEvent());
  }

  void goBack() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarCustom(title: isNew ? 'Crear Nueva Caja' : 'Editar Caja'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    label: 'Fecha',
                    controller: _registerDateController,
                    readOnly: true,
                    prefixIcon: Icons.calendar_today,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Por favor ingrese la fecha.'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Saldo Inicial',
                    controller: _openingAmountController,
                    prefixIcon: Icons.monetization_on_outlined,
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
                  AppButton(title: '', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
