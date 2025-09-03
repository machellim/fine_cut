import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/bloc/product/products_list/products_list_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_crud/purchase_crud_bloc.dart';
import 'package:fine_cut/bloc/purchase/purchase_list/purchase_list_bloc.dart';
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

  // ===== banner ========
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

  @override
  void initState() {
    super.initState();
    // load Purchases
    context.read<PurchaseListBloc>().add(
      LoadPurchasesListEvent(AppEventSource.list),
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
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(right: 8.0),
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
                          'Fecha:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(registerDate),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(left: 8.0),
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
              ],
            ),

            const SizedBox(height: 20),

            // ExpansionPanelList.radio con primer panel abierto por defecto
            ExpansionPanelList.radio(
              initialOpenPanelValue: 1,
              expansionCallback: (index, isExpanded) {
                if (isExpanded) {
                  print("Panel $index abierto");
                } else {
                  print("Panel $index cerrado");
                }
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
                          onPressed: () {
                            Navigator.pushNamed(context, 'new-sale');
                          },
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap:
                              true, // importante para que funcione dentro de Column
                          physics:
                              const NeverScrollableScrollPhysics(), // evita scroll interno
                          itemCount: 5, // número de elementos
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                AppListItem(
                                  title: Text(
                                    'product',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  description: Text('2'),
                                  price: 5,
                                  onEdit: () {},

                                  onDelete: () {},
                                ),
                              ],
                            );
                          },
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
                                  context.read<PurchaseListBloc>().add(
                                    LoadPurchasesListEvent(AppEventSource.list),
                                  );
                                }
                                if (state is PurchaseDeletionFailure) {
                                  _showTopBannerPurchase(
                                    'Error al eliminar compra',
                                    type: AppBannerType.error,
                                  );
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
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.products.length,
                                      itemBuilder: (context, index) {
                                        final purchase = state.products[index];
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
                                                .read<PaymentMethodListBloc>();
                                            final selectedPaymentMethod =
                                                await repoPaymentMethod
                                                    .paymentMethodDao
                                                    .getById(
                                                      purchase.paymentMethodId,
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
                    padding: EdgeInsets.all(16),
                    child: Text('Contenido de compras'),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 3,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Ingresos Varios')),
                  body: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Contenido de otros gastos'),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 4,
                  headerBuilder: (context, isExpanded) =>
                      const ListTile(title: AppTitle(text: 'Pérdidas')),
                  body: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
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
          title: '¿Seguro que deseas eliminar esta venta?',
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
}
