import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/bloc/reports/parent_product_purchases_list/parent_product_purchases_list_bloc.dart';
import 'package:fine_cut/bloc/reports/parent_product_sales_list/parent_product_sales_list_bloc.dart';

class ParentProductSalesListScreen extends StatefulWidget {
  const ParentProductSalesListScreen({super.key});

  @override
  State<ParentProductSalesListScreen> createState() =>
      _ParentProductSalesListScreenState();
}

class _ParentProductSalesListScreenState
    extends State<ParentProductSalesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ParentProductPurchasesListBloc>().add(
      LoadParentProductPurchasesEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganancias Productos Principales'),
        backgroundColor: primaryColor,
      ),
      body: BlocBuilder<ParentProductPurchasesListBloc, ParentProductPurchasesListState>(
        builder: (context, state) {
          if (state is ParentProductPurchasesListSuccess) {
            if (state.purchases.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: AppMessages.getAppMessage('emptyList'),
                  messageType: MessageType.info,
                ),
              );
            }

            return ListView.builder(
              itemCount: state.purchases.length,
              itemBuilder: (context, index) {
                final purchase = state.purchases[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: cardColor,
                  child: ExpansionTile(
                    collapsedIconColor: primaryColor,
                    iconColor: primaryColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            purchase.aliasProductName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (purchase.isSoldOut)
                          AppBadgeStatus(
                            text: 'Agotado',
                            type: BadgeType.warning,
                          )
                        else
                          AppBadgeStatus(
                            text: 'Disponible',
                            type: BadgeType.success,
                          ),
                      ],
                    ),

                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: theme.textTheme.bodyMedium,
                            children: [
                              const TextSpan(
                                text: 'Cantidad: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '${purchase.quantity}'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: theme.textTheme.bodyMedium,
                            children: [
                              const TextSpan(
                                text: 'Total Compra: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    '\$${AppUtils.formatDouble(purchase.totalCost)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        // Se maneja en cada BlocProvider
                      }
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (purchase.notes != null &&
                                purchase.notes!.isNotEmpty)
                              Text(
                                'Notas: ${purchase.notes}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: theme.hintColor,
                                ),
                              ),
                            const SizedBox(height: 12),
                            Text(
                              'Ventas generadas:',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            BlocProvider(
                              create: (_) => ParentProductSalesListBloc(
                                saleDao: context.read<AppDatabase>().saleDao,
                              )..add(ParentProductSalesEvent(purchase.id)),
                              child:
                                  BlocBuilder<
                                    ParentProductSalesListBloc,
                                    ParentProductSalesListState
                                  >(
                                    builder: (context, salesState) {
                                      if (salesState
                                          is ParentProductSalesListLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (salesState
                                          is ParentProductSalesListSuccess) {
                                        final sales = salesState.sales;

                                        if (sales.isEmpty) {
                                          return Text(
                                            'No se han registrado ventas.',
                                            style: theme.textTheme.bodyMedium,
                                          );
                                        }

                                        // Total ventas para esta purchase
                                        final totalIncome = sales.fold<double>(
                                          0.0,
                                          (prev, sale) =>
                                              prev + (sale.totalPrice ?? 0),
                                        );

                                        final difference =
                                            totalIncome - purchase.totalCost;

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: theme
                                                        .textTheme
                                                        .bodyMedium,
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Total Ventas: ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '\$${AppUtils.formatDouble(totalIncome)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: theme
                                                        .textTheme
                                                        .bodyMedium,
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Ganancia: ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '\$ ${AppUtils.formatDouble(difference)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: difference < 0
                                                              ? Colors
                                                                    .redAccent // negative → red
                                                              : theme
                                                                    .colorScheme
                                                                    .primary, // positive → adapts to dark/light mode
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: sales.length,
                                              separatorBuilder: (_, __) =>
                                                  const Divider(height: 8),
                                              itemBuilder: (context, sIndex) {
                                                final sale = sales[sIndex];
                                                return ListTile(
                                                  dense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Text(
                                                    sale.aliasProductName,
                                                    style: theme
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  subtitle: Text(
                                                    'Cantidad: ${sale.quantity}, Total: \$${AppUtils.formatDouble(sale.totalPrice)}',
                                                    style: theme
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  leading: Icon(
                                                    Icons.local_offer_outlined,
                                                    color: primaryColor,
                                                  ),
                                                  trailing: Text(
                                                    AppUtils.formatDateTime(
                                                      sale.saleDate,
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      } else if (salesState
                                          is ParentProductSalesListFailure) {
                                        return Text(
                                          'Error: ${salesState.message}',
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ParentProductPurchasesListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ParentProductPurchasesListFailure) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Estado Desconocido',
                style: theme.textTheme.bodyMedium,
              ),
            );
          }
        },
      ),
    );
  }
}
