// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class AppBarCustom extends AppBar {
  AppBarCustom({
    super.key,
    required String title,
    bool centerTitle = true,
    List<Widget>? actions,
    Widget? leading, // 🔹 Nuevo parámetro opcional
    bool showShadow = true,
  }) : super(
         title: Text(title),
         centerTitle: centerTitle,
         actions: actions,
         leading: leading, // 🔹 Se pasa al AppBar
         elevation: showShadow ? 1.5 : 0.0,
         backgroundColor: Colors.transparent,
         foregroundColor: null, // se adapta al tema
         titleTextStyle: null,
         systemOverlayStyle: null,
       );
}
