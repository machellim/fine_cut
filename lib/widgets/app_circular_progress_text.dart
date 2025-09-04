import 'package:flutter/material.dart';

class AppCircularProgressText extends StatelessWidget {
  final String messageLoading;

  const AppCircularProgressText({
    super.key,
    this.messageLoading = "Cargando...",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            messageLoading,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: theme.colorScheme.onSurface, // ✔️ Se adapta al tema
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary, // ✔️ Usa el esquema de color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
