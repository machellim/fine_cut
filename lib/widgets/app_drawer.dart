import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext appContext;
  const AppDrawer({super.key, required this.appContext});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium!;
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
                    colorScheme.primary,
                    colorScheme.primary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimary.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.point_of_sale,
                            size: 40,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Cajamiga',
                          style: textTheme.headlineSmall!.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            'Controla tus compras, ventas, gastos y más.',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall!.copyWith(
                              color: colorScheme.onPrimary.withValues(
                                alpha: 0.8,
                              ),
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.close_sharp,
                        color: colorScheme.onPrimary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Sección: Visualizacion de cajas ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.view_comfy, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  'Visualización de Cajas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.history_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Historial de Cajas', style: textStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'cash-register-list');
            },
          ),

          // --- Sección: Administración ---
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.settings, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  'Administración',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Categorías', style: textStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'categories-list');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.inventory,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Productos', style: textStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'product-list');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Formas de Pago', style: textStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'payment-method-list');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.numbers,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Stock Producto Entero', style: textStyle),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'parent-product-stock');
            },
          ),

          // Sección Reportes
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.insert_chart_outlined,
                  size: 20,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 8),
                Text(
                  'Reportes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.attach_money,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Ventas productos principales', style: textStyle),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'parent-product-sales-list');
            },
          ),

          // --- Sección: Gestión de Información ---
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.backup_table, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  'Gestión de Información',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.import_export,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Cargar Información', style: textStyle),
            onTap: () async {},
          ),
          /*ListTile(
            leading: Icon(Icons.refresh),
            title: Text('Resetear Base de Datos'),
            onTap: () => _confirmResetDatabase(context),
          ),*/
          // backup
          ListTile(
            leading: Icon(
              Icons.backup,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Respaldar información', style: textStyle),
          ),
        ],
      ),
    );
  }
}
