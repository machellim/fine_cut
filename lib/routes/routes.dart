import 'package:fine_cut/screens/financial_dashboard.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'financial-dashboard': (BuildContext context) {
    return FinancialDashboardScreen();
  },
};

/*Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'check-totals':
      final user = settings.arguments as User;
      return MaterialPageRoute(
        builder: (context) => CheckTotalsScreen(user: user),
      );
    default:
      return null; // o una ruta por defecto
  }
}*/
