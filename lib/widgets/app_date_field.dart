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
      text: _formatDate(_selectedDate!),
    );
    _controller = widget.controller ?? _internalController;
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

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
        _controller.text = _formatDate(picked);
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
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: _controller,
      readOnly: true,
      enabled: widget.enabled,
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
