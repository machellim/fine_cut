import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? drawer; // Drawer opcional

  const AppScaffold({super.key, required this.body, this.appBar, this.drawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(title: const Text('BizControl')),
      drawer: drawer, // Drawer opcional
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: body,
      ),
    );
  }
}
