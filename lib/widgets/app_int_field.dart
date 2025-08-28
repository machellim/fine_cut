import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppIntField extends StatefulWidget {
  final String label;
  final Function(String) onSaved;
  final String? errorText;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool validate;
  final Function(String)? onChanged;

  const AppIntField({
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
  State<AppIntField> createState() => _AppIntFieldState();
}

class _AppIntFieldState extends State<AppIntField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      style: TextStyle(color: colorScheme.onSurface),
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
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // solo dígitos enteros
      ],
      validator: widget.validate
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un número';
              }
              final numValue = int.tryParse(value);
              if (numValue == null) {
                return 'Número inválido';
              }
              if (numValue <= 0) {
                return 'El número debe ser mayor que 1';
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
