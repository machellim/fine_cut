import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String>? onSaved;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? errorText;
  final bool isMultiline;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final bool validate;
  final String? validationMessage;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final bool autofocus;
  final bool enabled;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.label,
    this.onSaved,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.isMultiline = false,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.validate = true,
    this.validationMessage,
    this.hintText,
    this.labelStyle,
    this.hintStyle,
    this.border,
    this.autofocus = false,
    this.enabled = true,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;
  TextEditingController? _internalController;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: widget.controller ?? _internalController,
      textCapitalization: TextCapitalization.sentences,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        errorText: widget.errorText,
        border:
            widget.border ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        enabledBorder:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withAlpha((0.38 * 255).round()),
              ),
            ),
        focusedBorder:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
        errorBorder:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: colorScheme.error, width: 2.0),
            ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ??
            TextStyle(
              color: colorScheme.onSurface.withAlpha((0.5 * 255).round()),
              fontStyle: FontStyle.italic,
              fontSize: 13.0,
            ),
      ),
      obscureText: _isObscured,
      keyboardType: widget.isMultiline
          ? TextInputType.multiline
          : widget.keyboardType,
      maxLines: widget.isMultiline ? 5 : 1,
      validator:
          widget.validator ??
          (widget.validate
              ? (value) => (value == null || value.isEmpty)
                    ? (widget.validationMessage ?? 'Please enter some text')
                    : null
              : null),
      onSaved: widget.onSaved != null
          ? (value) {
              if (value != null) widget.onSaved!(value);
            }
          : null,
      onChanged: widget.onChanged,
    );
  }
}
