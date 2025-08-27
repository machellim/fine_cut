import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;

  const AppTitle({
    super.key,
    required this.text,
    this.style,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: textAlign,
        style:
            style ??
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }
}
