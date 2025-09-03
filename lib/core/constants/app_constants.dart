import 'package:flutter/material.dart';

class AppConstants {
  // database name
  static const String databaseName = 'fine_cut.sqlite';

  // limit results for search
  static const int searchResultsLimit = 100;

  // limit results for listing
  static const int listResultsLimit = 500;

  // default padding for screens
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 40.0,
  );

  // grid padding
  static const EdgeInsets gridPadding = EdgeInsets.only(bottom: 16.0);
}
