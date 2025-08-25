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
    IconData icon;
    Color color;
    String? label;

    // Determinar icono y color según el tipo de mensaje
    switch (messageType) {
      case MessageType.error:
        icon = Icons.error_outline;
        color = Colors.red;
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
      default:
        icon = Icons.info_outline;
        color = Colors.blue;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1), // Fondo con opacidad
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: TextStyle(color: color, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
