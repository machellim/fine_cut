import 'package:drift/drift.dart' as drift;
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
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  bool isNew = true;

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void goBack() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Nueva Inversión' : 'Editar Inversión'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Notas',
                    controller: _notesController,
                    isMultiline: true,
                    validate: true, // Esto hace que sea requerido
                    onSaved: (value) {},
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
