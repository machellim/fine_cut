import 'package:flutter/material.dart';

// Widget reutilizable para mostrar un cuadro de diálogo de alerta
class AppAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm; // Acción cuando el usuario confirma
  final VoidCallback onCancel; // Acción cuando el usuario cancela

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final iconColor = isDark ? Colors.amberAccent : Colors.orange;

    return AlertDialog(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      content: Row(
        children: [
          Icon(Icons.info_outline, color: iconColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              content,
              style: TextStyle(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botón de Cancelar
            TextButton(
              onPressed: () {
                onCancel();
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            // Botón de Confirmar
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text(
                'Continuar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
