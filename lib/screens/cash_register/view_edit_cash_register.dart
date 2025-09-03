import 'package:fine_cut/bloc/cash_register/available_balance/available_balance_bloc.dart';
import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_crud/purchase_crud_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_list/purchase_list_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_crud/sale_crud_bloc.dart';
import 'package:fine_cut/bloc/sale/sale_list/sale_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/models/banner_state.dart';
import 'package:fine_cut/widgets/app_alert_dialog.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_drawer.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_simple_center_text.dart';
import 'package:fine_cut/widgets/app_title.dart';
import 'package:fine_cut/widgets/app_top_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';

class ViewEditCashRegisterScreen extends StatefulWidget {
  final CashRegister cashRegister;
  const ViewEditCashRegisterScreen({super.key, required this.cashRegister});

  @override
  State<ViewEditCashRegisterScreen> createState() =>
      _ViewEditCashRegisterScreenState();
}

class _ViewEditCashRegisterScreenState
    extends State<ViewEditCashRegisterScreen> {
  bool isNew = true;

  // ===== banner purchase ========
  BannerState _bannerPurchaseState = BannerState.initial();
  void _showTopBannerPurchase(
    String message, {
    AppBannerType type = AppBannerType.success,
  }) {
    setState(() {
      _bannerPurchaseState = _bannerPurchaseState.copyWith(
        show: true,
        message: message,
        type: type,
      );
    });
  }

  void _closeBannerPurchase() {
    setState(() {
      _bannerPurchaseState = _bannerPurchaseState.copyWith(show: false);
    });
  }

  // ===== banner sale ========
  BannerState _bannerSaleState = BannerState.initial();
  void _showTopBannerSale(
    String message, {
    AppBannerType type = AppBannerType.success,
  }) {
    setState(() {
      _bannerSaleState = _bannerSaleState.copyWith(
        show: true,
        message: message,
        type: type,
      );
    });
  }

  void _closeBannerSale() {
    setState(() {
      _bannerSaleState = _bannerSaleState.copyWith(show: false);
    });
  }

  void _loadAvailableBalance() {
    context.read<AvailableBalanceBloc>().add(
      LoadAvailableBalanceEvent(widget.cashRegister.id),
    );
  }

  @override
  void initState() {
    super.initState();

    // load available balance
    _loadAvailableBalance();

    // load Purchases
    context.read<PurchaseListBloc>().add(
      LoadPurchasesListEvent(AppEventSource.list, widget.cashRegister.id),
    );

    // load Purchases
    context.read<SaleListBloc>().add(
      LoadSalesListEvent(AppEventSource.list, widget.cashRegister.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final cashRegister = widget.cashRegister;
    final registerDate = AppUtils.formatDate(cashRegister.registerDate);

    return AppScaffold(
      appBar: AppBarCustom(
        title: isNew ? 'Ventas' : 'Editar Caja',
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'close-cash-register') {
                // acción de cerrar caja
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'close-cash-register',
                child: Text('Cerrar Caja'),
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(appContext: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
        child: Column(
          children: [
            // Fila de Fecha y Saldo Inicial
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Fecha Caja:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(registerDate),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Saldo Inicial:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${AppUtils.formatDouble(cashRegister.openingAmount)}',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Disponible:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        BlocBuilder<
                          AvailableBalanceBloc,
                          AvailableBalanceState
                        >(
                          builder: (context, state) {
                            if (state is AvailableBalanceLoading) {
                              return Text('Loading . .');
                            } else if (state is AvailableBalanceLoadSuccess) {
                              return Text(
                                '\$ ${AppUtils.formatDouble(state.availableBalance)}',
                              );
                            } else if (state is AvailableBalanceLoadFailure) {
                              return Text('Error');
                            } else {
                              return Text('Desconocido');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ExpansionPanelList.radio con primer panel abierto por defecto
            ExpansionPanelList.radio(
              initialOpenPanelValue: 0,
              expansionCallback: (index, isExpanded) {
                if (isExpanded) {
                } else {}
              },
              children: [
                ExpansionPanelRadio(
                  value: 0,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Ventas')),
                  body: Padding(
                    padding: AppConstants.gridPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppButton(
                          title: 'Agregar Venta',
                          onPressed: () async {
                            _closeBannerSale();

                            final repoPaymentMethod = context
                                .read<PaymentMethodListBloc>();
                            final paymentMethod = await repoPaymentMethod
                                .paymentMethodDao
                                .getPaymentMethodByName('Efectivo');
                            Navigator.pushNamed(
                              context,
                              'new-sale',
                              arguments: {
                                'defaultSelectedPaymentMethod': paymentMethod,
                                'cashRegisterId': cashRegister.id,
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        if (_bannerSaleState.show)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppTopBanner(
                              message: _bannerSaleState.message,
                              type: _bannerSaleState.type,
                              onClose: _closeBannerSale,
                            ),
                          ),
                        MultiBlocListener(
                          listeners: [
                            BlocListener<SaleCrudBloc, SaleCrudState>(
                              listener: (context, state) {
                                if (state is SaleDeletionSuccess) {
                                  _loadAvailableBalance();
                                  context.read<SaleListBloc>().add(
                                    LoadSalesListEvent(
                                      AppEventSource.list,
                                      widget.cashRegister.id,
                                    ),
                                  );
                                }
                                if (state is SaleDeletionFailure) {
                                  _showTopBannerPurchase(
                                    'Error al eliminar venta',
                                    type: AppBannerType.error,
                                  );
                                }
                                if (state is SaleCreationSuccess) {
                                  _loadAvailableBalance();
                                }
                                if (state is SaleUpdateSuccess) {
                                  _loadAvailableBalance();
                                }
                              },
                            ),
                            // List listener
                            BlocListener<SaleListBloc, SaleListState>(
                              listener: (context, state) {
                                if (state is SaleListLoadSuccess) {
                                  if (state.eventSource ==
                                      AppEventSource.create) {
                                    _showTopBannerSale(
                                      'Venta creada con éxito',
                                    );
                                  } else if (state.eventSource ==
                                      AppEventSource.update) {
                                    _showTopBannerSale(
                                      'Venta actualizada con éxito',
                                    );
                                  } else if (state.eventSource ==
                                      AppEventSource.delete) {
                                    _showTopBannerSale(
                                      'Venta eliminada con éxito',
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                          child: BlocBuilder<SaleListBloc, SaleListState>(
                            builder: (context, state) {
                              if (state is SaleListLoading) {
                                return AppLoadingScreen(
                                  message: AppMessages.getPurchaseMessage(
                                    'messageLoadingPurchase',
                                  ),
                                );
                              } else if (state is SaleListLoadSuccess) {
                                if (state.sales.isEmpty) {
                                  return AppSimpleCenterText(
                                    message: 'No hay información.',
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap:
                                        true, // importante para que funcione dentro de Column
                                    physics:
                                        const NeverScrollableScrollPhysics(), // evita scroll interno
                                    itemCount: state
                                        .sales
                                        .length, // número de elementos
                                    itemBuilder: (context, index) {
                                      final sale = state.sales[index];
                                      return Column(
                                        children: [
                                          AppListItem(
                                            title: Text(
                                              sale.aliasProductName,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            description: Text(
                                              'Cantidad: ${sale.quantity}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            price: sale.totalPrice,
                                            onEdit: () async {
                                              _closeBannerSale();
                                              // get selected product
                                              final repoProduct = context
                                                  .read<ProductsListBloc>();
                                              final selectedProduct =
                                                  await repoProduct.productDao
                                                      .getById(sale.productId);

                                              // get selected payment form
                                              final repoPaymentMethod = context
                                                  .read<
                                                    PaymentMethodListBloc
                                                  >();
                                              final selectedPaymentMethod =
                                                  await repoPaymentMethod
                                                      .paymentMethodDao
                                                      .getById(
                                                        sale.paymentMethodId,
                                                      );

                                              Navigator.pushNamed(
                                                context,
                                                'new-sale',
                                                arguments: {
                                                  'selectedProduct':
                                                      selectedProduct,
                                                  'selectedPaymentMethod':
                                                      selectedPaymentMethod,
                                                  'sale': sale,
                                                },
                                              );
                                            },
                                            onDelete: () {
                                              _showDeleteConfirmationSale(
                                                context,
                                                sale.id,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else if (state is SaleListLoadFailure) {
                                return const Center(
                                  child: Text('Error al cargar ventas'),
                                );
                              } else {
                                return const Center(
                                  child: Text('Estado desconocido'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Compras')),

                  body: Padding(
                    padding: AppConstants.gridPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppButton(
                          title: 'Agregar Compra',
                          onPressed: () async {
                            _closeBannerPurchase();
                            final repoPaymentMethod = context
                                .read<PaymentMethodListBloc>();
                            final paymentMethod = await repoPaymentMethod
                                .paymentMethodDao
                                .getPaymentMethodByName('Efectivo');

                            Navigator.pushNamed(
                              context,
                              'new-purchase',
                              arguments: {
                                'defaultSelectedPaymentMethod': paymentMethod,
                                'cashRegisterId': cashRegister.id,
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        if (_bannerPurchaseState.show)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppTopBanner(
                              message: _bannerPurchaseState.message,
                              type: _bannerPurchaseState.type,
                              onClose: _closeBannerPurchase,
                            ),
                          ),
                        MultiBlocListener(
                          listeners: [
                            // Listener del bloc de creación/edición/eliminación
                            BlocListener<PurchaseCrudBloc, PurchaseCrudState>(
                              listener: (context, state) {
                                if (state is PurchaseDeletionSuccess) {
                                  _loadAvailableBalance();
                                  context.read<PurchaseListBloc>().add(
                                    LoadPurchasesListEvent(
                                      AppEventSource.list,
                                      widget.cashRegister.id,
                                    ),
                                  );
                                }
                                if (state is PurchaseDeletionFailure) {
                                  _showTopBannerPurchase(
                                    'Error al eliminar compra',
                                    type: AppBannerType.error,
                                  );
                                }
                                if (state is PurchaseCreationSuccess) {
                                  _loadAvailableBalance();
                                }
                                if (state is PurchaseUpdateSuccess) {
                                  _loadAvailableBalance();
                                }
                              },
                            ),

                            // Listener de la lista
                            BlocListener<PurchaseListBloc, PurchaseListState>(
                              listener: (context, state) {
                                if (state is PurchaseListLoadSuccess) {
                                  if (state.eventSource ==
                                      AppEventSource.create) {
                                    _showTopBannerPurchase(
                                      'Compra creada con éxito',
                                    );
                                  } else if (state.eventSource ==
                                      AppEventSource.update) {
                                    _showTopBannerPurchase(
                                      'Compra actualizada con éxito',
                                    );
                                  } else if (state.eventSource ==
                                      AppEventSource.delete) {
                                    _showTopBannerPurchase(
                                      'Compra eliminada con éxito',
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                          child:
                              BlocBuilder<PurchaseListBloc, PurchaseListState>(
                                builder: (context, state) {
                                  if (state is PurchaseListLoading) {
                                    return AppLoadingScreen(
                                      message: AppMessages.getPurchaseMessage(
                                        'messageLoadingPurchase',
                                      ),
                                    );
                                  } else if (state is PurchaseListLoadSuccess) {
                                    if (state.purchases.isEmpty) {
                                      return AppSimpleCenterText(
                                        message: 'No hay información.',
                                      );
                                    } else {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.purchases.length,
                                        itemBuilder: (context, index) {
                                          final purchase =
                                              state.purchases[index];
                                          return AppListItem(
                                            title: Text(
                                              purchase.aliasProductName,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            description: Text(
                                              'Cantidad ${purchase.quantity}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            price: purchase.totalCost,
                                            onEdit: () async {
                                              _closeBannerPurchase();
                                              // get selected product
                                              final repoProduct = context
                                                  .read<ProductsListBloc>();
                                              final selectedProduct =
                                                  await repoProduct.productDao
                                                      .getById(
                                                        purchase.productId,
                                                      );

                                              // get selected payment form
                                              final repoPaymentMethod = context
                                                  .read<
                                                    PaymentMethodListBloc
                                                  >();
                                              final selectedPaymentMethod =
                                                  await repoPaymentMethod
                                                      .paymentMethodDao
                                                      .getById(
                                                        purchase
                                                            .paymentMethodId,
                                                      );

                                              Navigator.pushNamed(
                                                context,
                                                'new-purchase',
                                                arguments: {
                                                  'selectedProduct':
                                                      selectedProduct,
                                                  'selectedPaymentMethod':
                                                      selectedPaymentMethod,
                                                  'purchase': purchase,
                                                },
                                              );
                                            },
                                            onDelete: () {
                                              _showDeleteConfirmationPurchase(
                                                context,
                                                purchase.id,
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }
                                  } else if (state is PurchaseListLoadFailure) {
                                    return const Center(
                                      child: Text('Error al cargar compras'),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text('Estado desconocido'),
                                    );
                                  }
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 2,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Gastos')),
                  body: const Padding(
                    padding: AppConstants.gridPadding,
                    child: Text('Contenido de gastos'),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 3,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Ingresos Varios')),
                  body: const Padding(
                    padding: AppConstants.gridPadding,
                    child: Text('Contenido de ingresos'),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 4,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Pérdidas')),
                  body: const Padding(
                    padding: AppConstants.gridPadding,
                    child: Text('Productos dañados, robados, perdidos, etc.'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationPurchase(BuildContext context, int purchaseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que deseas eliminar esta compra?',
          content: 'Esta acción no se puede deshacer.',
          onCancel: () {
            // close dialog
          },
          onConfirm: () {
            // Acción de confirmar
            context.read<PurchaseCrudBloc>().add(
              DeletePurchaseEvent(purchaseId),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationSale(BuildContext context, int saleId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que deseas eliminar esta venta?',
          content: 'Esta acción no se puede deshacer.',
          onCancel: () {
            // close dialog
          },
          onConfirm: () {
            // Acción de confirmar
            context.read<SaleCrudBloc>().add(DeleteSaleEvent(saleId));
          },
        );
      },
    );
  }
}
