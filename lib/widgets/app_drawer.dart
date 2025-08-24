import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext appContext;
  const AppDrawer({super.key, required this.appContext});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Encabezado del Drawer
          // Wrap your DrawerHeader with a SizedBox to guarantee its height
          SizedBox(
            height: 200.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(
                      context,
                    ).primaryColor.withAlpha((0.8 * 255).toInt()),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8.0),
              child: Stack(
                children: [
                  // Contenido centrado
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.point_of_sale,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Cajamiga',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            'Controla tus compras, ventas, gastos y más.',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 12,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botón para cerrar el Drawer en esquina superior izquierda
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close_sharp, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop(); // cierra el drawer
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Sección: Ventas & Compras ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Compras & Ventas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Compras'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'purchases-list');
            },
          ),
          ListTile(
            leading: Icon(Icons.point_of_sale),
            title: Text('Ventas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'sales-list');
            },
          ),
          Divider(),

          // --- Sección: Gestión de Productos ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Gestión de Productos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categorías'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'categories-list');
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Catálogo de Productos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'products-list');
            },
          ),
          Divider(),

          // --- Sección: Finanzas ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Finanzas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Estado de Caja'),
            onTap: () {
              final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
              Navigator.pop(context); // Cierra el Drawer siempre

              if (currentRoute != 'check-totals' && currentRoute != '/') {
                Navigator.pushNamed(
                  context,
                  'check-totals',
                ); // Solo navega si no estamos en check-totals
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Cierre de Caja'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'cash-review-list');
            },
          ),
          ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Otros Gastos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'other-expenses-list');
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt), // Icono para Tipos de Gastos
            title: Text('Tipos de Gastos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'expense-types-list');
            },
          ),

          ListTile(
            leading: Icon(Icons.add_chart), // Icono para Tipos de Gastos
            title: Text('Inversiones'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'investment-list');
            },
          ),
          Divider(),

          // --- Sección: Cuenta ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Gestión de Datos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.import_export),
            title: Text('Importar Base de Datos'),
            onTap: () async {},
          ),
          /*ListTile(
            leading: Icon(Icons.refresh),
            title: Text('Resetear Base de Datos'),
            onTap: () => _confirmResetDatabase(context),
          ),*/
          // backup
          ListTile(
            leading: Icon(Icons.backup),
            title: Text('Backup Base de Datos'),
          ),
          Divider(),
          // --- Sección: Cuenta ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Cuenta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () async {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'login',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
