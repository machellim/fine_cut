import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final Widget title;
  final Widget? description;
  final String? date;
  final double? price;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget? leading;

  const AppListItem({
    super.key,
    required this.title,
    this.description,
    this.date,
    this.price,
    this.onEdit,
    this.onDelete,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      leading: leading,
      title: DefaultTextStyle(
        style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
        child: title,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description != null) description!,
          if (date != null && date!.isNotEmpty) const SizedBox(height: 4),
          if (date != null && date!.isNotEmpty)
            Text(
              "📅 $date",
              style: textTheme.bodySmall!.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (price != null)
            Text(
              "\$${price!.toStringAsFixed(2)}",
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.tertiary, // verde/azul adaptable
              ),
            ),
          const SizedBox(width: 8),
          if (onEdit != null)
            IconButton(
              icon: Icon(Icons.edit, color: colorScheme.primary),
              tooltip: 'Editar',
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: Icon(Icons.delete, color: colorScheme.error),
              tooltip: 'Eliminar',
              onPressed: onDelete,
            ),
        ],
      ),
      tileColor: colorScheme.surfaceContainerHighest,
      // se adapta a claro/oscuro
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
