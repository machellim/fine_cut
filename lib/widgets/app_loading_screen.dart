import 'package:flutter/material.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';

class AppLoadingScreen extends StatelessWidget {
  final String message;

  const AppLoadingScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      // Fondo adaptado al modo oscuro/claro
      color: theme.colorScheme.surface.withValues(alpha: 0.9),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.2),
                blurRadius: 8,
              ),
            ],
          ),
          child: AppCircularProgressText(messageLoading: message),
        ),
      ),
    );
  }
}
