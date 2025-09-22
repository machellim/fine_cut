import 'package:flutter/material.dart';

class FloatingEmoji extends StatefulWidget {
  final String emoji;
  final Duration duration;

  const FloatingEmoji({
    super.key,
    this.emoji = "😌",
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<FloatingEmoji> createState() => _FloatingEmojiState();
}

class _FloatingEmojiState extends State<FloatingEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Fade in
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Escala pequeña → normal
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    // Después de la duración, fade out + encoger
    Future.delayed(widget.duration, () {
      if (!mounted) return;

      _fadeAnimation = Tween<double>(
        begin: 1,
        end: 0,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 0.3,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

      _controller.reverse().then((_) {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Align(
            alignment: Alignment(0, -0.9), // centrado horizontal, arriba
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            ),
          );
        },
        child: Text(widget.emoji, style: const TextStyle(fontSize: 50)),
      ),
    );
  }
}
