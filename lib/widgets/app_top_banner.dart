import 'package:flutter/material.dart';

enum AppBannerType { success, info, alert, error }

class AppTopBanner extends StatelessWidget {
  final String message;
  final AppBannerType type;
  final VoidCallback? onClose;

  const AppTopBanner({
    super.key,
    required this.message,
    this.type = AppBannerType.info,
    this.onClose,
  });

  Color _getBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (type) {
      case AppBannerType.success:
        return colorScheme.primary;
      case AppBannerType.info:
        return colorScheme.secondary;
      case AppBannerType.alert:
        return Colors.orange;
      case AppBannerType.error:
        return colorScheme.error;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case AppBannerType.success:
        return Icons.check_circle;
      case AppBannerType.info:
        return Icons.info;
      case AppBannerType.alert:
        return Icons.warning;
      case AppBannerType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _getBackgroundColor(context),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(_getIcon(), color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
