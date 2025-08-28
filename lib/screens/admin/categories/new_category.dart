import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_bloc.dart';
import 'package:fine_cut/bloc/category/category_crud/category_event.dart';
import 'package:fine_cut/bloc/category/category_crud/category_state.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_string_switch.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _statusController = TextEditingController();

  bool isNew = true;
  CategoriesCompanion categoryCompanion = CategoriesCompanion();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // restart state
    context.read<CategoryBloc>().add(ResetCategoryEvent());

    Future.microtask(() {
      final args = ModalRoute.of(context)?.settings.arguments as Category?;

      if (args != null) {
        categoryCompanion = CategoriesCompanion(
          id: drift.Value(args.id),
          name: drift.Value(args.name),
          description: drift.Value(args.description),
          status: drift.Value(args.status),
        );
        _nameController.text = args.name.toString();
        _descriptionController.text = args.description ?? '';
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
      context.read<CategoriesListBloc>().add(
        LoadCategoriesListEvent(eventSource),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Nueva Categoría' : 'Editar Categoría'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: 'Nombre Categoría',
                    onSaved: (value) {
                      categoryCompanion = categoryCompanion.copyWith(
                        name: drift.Value(value),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Descripción',
                    controller: _descriptionController,
                    isMultiline: true,
                    validate: false,
                    onSaved: (value) {
                      categoryCompanion = categoryCompanion.copyWith(
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
                          categoryCompanion = categoryCompanion.copyWith(
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
                  BlocConsumer<CategoryBloc, CategoryState>(
                    listener: (context, state) {
                      if (state is CategoryCreationSuccess) {
                        goBack(AppEventSource.create);
                      }
                      if (state is CategoryUpdateSuccess) {
                        goBack(AppEventSource.update);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is CategoryCreationInProgress;
                      return Column(
                        children: [
                          if (state is CategoryCreationFailure)
                            AppMessageType(
                              message: state.message,
                              messageType: MessageType.error,
                            ),
                          if (state is CategoryUpdateFailure)
                            AppMessageType(
                              message: state.message,
                              messageType: MessageType.error,
                            ),

                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              title: isNew
                                  ? 'Crear Categoría'
                                  : 'Actualizar Categoría',
                              isLoading: isLoading,
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        context.read<CategoryBloc>().add(
                                          CreateCategoryEvent(
                                            isNew ? 'create' : 'update',
                                            categoryCompanion,
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
