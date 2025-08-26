import 'package:flutter/material.dart';

enum MessageType { error, success, alert, info }

class AppMessageType extends StatelessWidget {
  final String message;
  final MessageType messageType;

  const AppMessageType({
    super.key,
    required this.message,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    IconData icon;
    Color color;
    String? label;

    // Determinar icono y color principal según el tipo de mensaje
    switch (messageType) {
      case MessageType.error:
        icon = Icons.error_outline;
        color = theme.colorScheme.error;
        label = 'Error';
        break;
      case MessageType.success:
        icon = Icons.check_circle_outline;
        color = Colors.green;
        label = 'Success';
        break;
      case MessageType.alert:
        icon = Icons.warning_amber_outlined;
        color = Colors.orange;
        label = 'Alert';
        break;
      case MessageType.info:
      default:
        icon = Icons.info_outline;
        color = theme.colorScheme.primary;
        label = 'Info';
        break;
    }

    // Fondo adaptado (ligero en light mode, más oscuro en dark mode)
    final backgroundColor = color.withOpacity(isDark ? 0.2 : 0.1);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
