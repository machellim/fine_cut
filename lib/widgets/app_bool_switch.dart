import 'package:flutter/material.dart';

class AppBoolSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final String activeText;
  final String inactiveText;
  final EdgeInsets padding;

  // Controller obligatorio
  final TextEditingController controller;

  const AppBoolSwitch({
    super.key,
    required this.controller,
    this.onChanged,
    this.activeText = "Activo",
    this.inactiveText = "Inactivo",
    this.padding = const EdgeInsets.symmetric(vertical: 0.0),
  });

  @override
  State<AppBoolSwitch> createState() => _AppBoolSwitchState();
}

class _AppBoolSwitchState extends State<AppBoolSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    // Inicializamos desde el controller (true/false)
    _value = widget.controller.text.toLowerCase() == 'true';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _value ? widget.activeText : widget.inactiveText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _value ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 10),
          Switch(
            value: _value,
            activeTrackColor: colorScheme.primary.withValues(alpha: 0.5),
            activeThumbColor: colorScheme.primary,
            inactiveTrackColor: colorScheme.surface,
            inactiveThumbColor: colorScheme.onSurface,
            onChanged: (val) {
              setState(() => _value = val);

              // Actualizamos el controller
              widget.controller.text = val.toString();

              widget.onChanged?.call(val);
            },
          ),
        ],
      ),
    );
  }
}
