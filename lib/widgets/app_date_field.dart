import 'package:fine_cut/core/utils/helpers.dart';
import 'package:flutter/material.dart';

class AppDateField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final bool enabled;
  final TextStyle? labelStyle;
  final InputBorder? border;

  /// Nuevo: validador personalizado
  final FormFieldValidator<String>? validator;

  /// Nuevo: activar validación simple
  final bool validate;

  /// Nuevo: mensaje para campo requerido
  final String? validationMessage;

  const AppDateField({
    super.key,
    required this.label,
    this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.enabled = true,
    this.labelStyle,
    this.border,
    this.validator,
    this.validate = false,
    this.validationMessage,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  late TextEditingController _internalController;
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();

    _internalController = TextEditingController(
      text: AppUtils.formatDate(_selectedDate!),
    );
    _controller = widget.controller ?? _internalController;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = AppUtils.formatDate(picked);
      });
      if (widget.onDateSelected != null) widget.onDateSelected!(picked);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: _controller,
      readOnly: true,
      enabled: widget.enabled,
      validator:
          widget.validator ??
          (widget.validate
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return widget.validationMessage ?? 'Campo requerido';
                  }
                  return null;
                }
              : null),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        border:
            widget.border ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        suffixIcon: const Icon(Icons.calendar_today),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onTap: widget.enabled ? _pickDate : null,
    );
  }
}
