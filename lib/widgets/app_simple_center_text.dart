import 'package:flutter/material.dart';

class AppSimpleCenterText extends StatelessWidget {
  final String message;
  final TextStyle? style;

  const AppSimpleCenterText({super.key, required this.message, this.style});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: style ?? const TextStyle(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
