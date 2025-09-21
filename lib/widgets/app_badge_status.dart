import 'package:flutter/material.dart';

class AppBadgeStatus extends StatelessWidget {
  final String text;
  final BadgeType type;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final TextStyle? textStyle;

  const AppBadgeStatus({
    super.key,
    required this.text,
    required this.type,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.borderRadius = 12,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    switch (type) {
      case BadgeType.error:
        backgroundColor = Colors.redAccent;
        break;
      case BadgeType.warning:
        backgroundColor = Colors.orangeAccent;
        break;
      case BadgeType.success:
        backgroundColor = Colors.green;
        break;
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style:
            textStyle ??
            theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

enum BadgeType { error, warning, success }
