import 'package:flutter/material.dart';
import 'package:fine_cut/db/enums.dart';

class AppDescriptionListItem extends StatelessWidget {
  final String text;
  final String status;
  final TextStyle? style;

  const AppDescriptionListItem({
    super.key,
    required this.text,
    required this.status,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.onSurface;

    // Color según estado activo/inactivo
    final color = status == AppActiveStatus.active.name
        ? baseColor
        : baseColor.withValues(alpha: 0.3);

    return Text(
      text,
      style: (style ?? const TextStyle()).copyWith(
        color: color,
        fontWeight: FontWeight.w100,
      ),
    );
  }
}
