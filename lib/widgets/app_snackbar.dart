import 'package:flutter/material.dart';

enum SnackBarType { success, info, alert, error }

class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    // Colores según tipo
    final Map<SnackBarType, Color> colors = {
      SnackBarType.success: colorScheme.primary,
      SnackBarType.info: colorScheme.secondary,
      SnackBarType.alert: colorScheme.tertiary,
      SnackBarType.error: colorScheme.error,
    };

    final Map<SnackBarType, IconData> icons = {
      SnackBarType.success: Icons.check_circle,
      SnackBarType.info: Icons.info,
      SnackBarType.alert: Icons.warning,
      SnackBarType.error: Icons.error,
    };

    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: colors[type],
      behavior: SnackBarBehavior.floating, // flota sobre la UI
      content: Row(
        children: [
          Icon(icons[type], color: colorScheme.onPrimary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );

    // Muestra el SnackBar
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar() // cierra el anterior si hay
      ..showSnackBar(snackBar);
  }
}
