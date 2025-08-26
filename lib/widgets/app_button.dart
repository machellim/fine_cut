import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double fontSize;
  final EdgeInsets padding;
  final bool isLoading;

  const AppButton({
    super.key,
    this.title = "",
    this.onPressed,
    this.fontSize = 20.0,
    this.padding = const EdgeInsets.symmetric(vertical: 0.0),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          minimumSize: const Size(200.0, 50.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
