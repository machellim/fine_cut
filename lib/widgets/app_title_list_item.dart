import 'package:flutter/material.dart';
import 'package:fine_cut/core/enums/enums.dart';

class AppTitleListItem extends StatelessWidget {
  final String text;
  final String status;
  final TextStyle? style;

  /// Este widget está pensado para títulos (name) que deben ser bold
  const AppTitleListItem({
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
        fontWeight: FontWeight.bold, // siempre bold para “name”
      ),
    );
  }
}
