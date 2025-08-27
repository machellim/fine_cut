import 'package:flutter/material.dart';

class AppSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String activeText;
  final String inactiveText;
  final EdgeInsets padding;

  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeText = "Activo",
    this.inactiveText = "Inactivo",
    this.padding = const EdgeInsets.symmetric(vertical: 0.0),
  });

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
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
            inactiveTrackColor: colorScheme.surfaceContainerHighest,
            inactiveThumbColor: colorScheme.onSurface,
            onChanged: (val) {
              setState(() => _value = val);
              widget.onChanged?.call(val);
            },
          ),
        ],
      ),
    );
  }
}
