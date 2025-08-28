import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNumberField extends StatefulWidget {
  final String label;
  final Function(String) onSaved;
  final String? errorText;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool validate;
  final Function(String)? onChanged;

  const AppNumberField({
    super.key,
    required this.label,
    required this.onSaved,
    this.errorText,
    this.controller,
    this.readOnly,
    this.validate = true,
    this.onChanged,
  });

  @override
  State<AppNumberField> createState() => _AppNumberFieldState();
}

class _AppNumberFieldState extends State<AppNumberField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      style: TextStyle(color: colorScheme.onSurface), // texto adaptable
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        errorText: widget.errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,2}$'),
        ), // enteros y hasta 2 decimales
      ],
      validator: widget.validate
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un número';
              }
              final numValue = double.tryParse(value);
              if (numValue == null) {
                return 'Número inválido';
              }
              if (numValue > 1000000) {
                return 'El número no puede ser mayor a 1,000,000';
              }
              return null;
            }
          : null,
      onSaved: (value) => widget.onSaved(value!),
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
