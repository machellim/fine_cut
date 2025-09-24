import 'package:fine_cut/bloc/cash_register/available_balance/available_balance_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_close/cash_register_close_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_update_date/cash_register_update_date_bloc.dart';
import 'package:fine_cut/bloc/expense/expense_crud/expense_crud_bloc.dart';
import 'package:fine_cut/bloc/expense/expense_list/expense_list_bloc.dart';
import 'package:fine_cut/bloc/income/income_crud/income_crud_bloc.dart';
import 'package:fine_cut/bloc/income/income_list/income_list_bloc.dart';
import 'package:fine_cut/bloc/inventory_adjustment/inventory_adjustment_crud/inventory_adjustment_crud_bloc.dart';
import 'package:fine_cut/bloc/inventory_adjustment/inventory_adjustment_list/inventory_adjustment_list_bloc.dart';
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
import 'package:fine_cut/screens/home_wrapper.dart';
import 'package:fine_cut/widgets/app_alert_dialog.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_drawer.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_simple_center_text.dart';
import 'package:fine_cut/widgets/app_title.dart';
import 'package:fine_cut/widgets/app_top_banner.dart';
import 'package:fine_cut/widgets/app_total_footer.dart';
import 'package:fine_cut/widgets/emoji_popup/show_floating_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fine_cut/widgets/app_scaffold.dart';

class ViewEditCashRegisterScreen extends StatefulWidget {
  final CashRegister cashRegister;
  final bool readOnly;
  final bool showDrawer;
  const ViewEditCashRegisterScreen({
    super.key,
    required this.cashRegister,
    this.readOnly = false,
    this.showDrawer = true,
  });

  @override
  State<ViewEditCashRegisterScreen> createState() =>
      _ViewEditCashRegisterScreenState();
}

class _ViewEditCashRegisterScreenState
    extends State<ViewEditCashRegisterScreen> {
  late CashRegister _cashRegister;
  late bool _readOnly;

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

  // ===== banner expense ========
  BannerState _bannerExpenseState = BannerState.initial();
  void _showTopBannerExpense(
    String message, {
    AppBannerType type = AppBannerType.success,
  }) {
    setState(() {
      _bannerExpenseState = _bannerExpenseState.copyWith(
        show: true,
        message: message,
        type: type,
      );
    });
  }

  void _closeBannerExpense() {
    setState(() {
      _bannerExpenseState = _bannerExpenseState.copyWith(show: false);
    });
  }

  // ===== banner expense ========
  BannerState _bannerIncomeState = BannerState.initial();
  void _showTopBannerIncome(
    String message, {
    AppBannerType type = AppBannerType.success,
  }) {
    setState(() {
      _bannerIncomeState = _bannerIncomeState.copyWith(
        show: true,
        message: message,
        type: type,
      );
    });
  }

  void _closeBannerIncome() {
    setState(() {
      _bannerIncomeState = _bannerIncomeState.copyWith(show: false);
    });
  }

  // ===== banner inventory adjustment ========
  BannerState _bannerInventoryAdjustmentState = BannerState.initial();
  void _showTopBannerInventoryAdjustment(
    String message, {
    AppBannerType type = AppBannerType.success,
  }) {
    setState(() {
      _bannerInventoryAdjustmentState = _bannerInventoryAdjustmentState
          .copyWith(show: true, message: message, type: type);
    });
  }

  void _closeBannerInventoryAdjustment() {
    setState(() {
      _bannerInventoryAdjustmentState = _bannerInventoryAdjustmentState
          .copyWith(show: false);
    });
  }

  // ===== banner cash register update date ========
  BannerState _bannerUpdateDateState = BannerState.initial();
  void _showTopBannerUpdateDate(
    String message, {
    AppBannerType type = AppBannerType.success,
  }) {
    setState(() {
      _bannerUpdateDateState = _bannerUpdateDateState.copyWith(
        show: true,
        message: message,
        type: type,
      );
    });
  }

  void _closeBannerUpdateDate() {
    setState(() {
      _bannerUpdateDateState = _bannerUpdateDateState.copyWith(show: false);
    });
  }
  //===============================

  void _loadAvailableBalance() {
    context.read<AvailableBalanceBloc>().add(
      LoadAvailableBalanceEvent(_cashRegister.id),
    );
  }

  @override
  void initState() {
    super.initState();

    //
    _cashRegister = widget.cashRegister;
    _readOnly = widget.readOnly;

    // restart state
    context.read<CashRegisterUpdateDateBloc>().add(
      ResetUpdateCashRegisterDateEvent(),
    );

    // load available balance
    _loadAvailableBalance();

    // load Purchases
    context.read<PurchaseListBloc>().add(
      LoadPurchasesListEvent(AppEventSource.list, _cashRegister.id),
    );

    // load Purchases
    context.read<SaleListBloc>().add(
      LoadSalesListEvent(AppEventSource.list, _cashRegister.id),
    );

    // Load Expenses
    context.read<ExpenseListBloc>().add(
      LoadExpensesListEvent(AppEventSource.list, _cashRegister.id),
    );

    // Load Incomes
    context.read<IncomeListBloc>().add(
      LoadIncomesListEvent(AppEventSource.list, _cashRegister.id),
    );

    // Load Inventory Adjustments
    context.read<InventoryAdjustmentListBloc>().add(
      LoadInventoryAdjustmentListEvent(AppEventSource.list, _cashRegister.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cashRegisterStatus = _cashRegister.status == CashRegisterStatus.open
        ? 'Abierta'
        : 'Cerrada';

    return AppScaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _readOnly ? 'Visualización Caja' : 'Caja Actual',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 8),
            AppBadgeStatus(
              text: cashRegisterStatus, // "Abierta" o "Cerrada"
              type: cashRegisterStatus == 'Abierta'
                  ? BadgeType.success
                  : BadgeType.error,
            ),
          ],
        ),
        centerTitle: true,
        actions: !_readOnly
            ? [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'close-cash-register') {
                      _showConfirmationCloseCashRegister(
                        context,
                        _cashRegister.id,
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    if (_cashRegister.status == CashRegisterStatus.open)
                      const PopupMenuItem(
                        value: 'close-cash-register',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.lock),
                            SizedBox(width: 8),
                            Text('Cerrar Caja'),
                          ],
                        ),
                      ),
                    PopupMenuItem(
                      value: 'update-cash-register-date',
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          SizedBox(width: 8),
                          Text('Actualizar Fecha'),
                        ],
                      ),
                      onTap: () {
                        _showUpdateCashRegisterDateDialog(
                          context,
                          _cashRegister,
                        );
                      },
                    ),
                  ],
                ),
              ]
            : null,
      ),
      drawer: widget.showDrawer ? AppDrawer(appContext: context) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
        child: BlocConsumer<CashRegisterCloseBloc, CashRegisterCloseState>(
          listener: (context, state) {
            if (state is CloseCashRegisterSuccess) {
              final database = RepositoryProvider.of<AppDatabase>(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HomeWrapper(database: database),
                ),
                (route) => false, // elimina todas las rutas anteriores
              );
            }
          },
          builder: (context, state) {
            if (state is CloseCashRegisterLoading) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: AppCircularProgressText(
                    messageLoading: AppMessages.getCashRegistersMessage(
                      'messageClosingCashRegister',
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: [
                if (state is CloseCashRegisterFailure)
                  AppMessageType(
                    message: AppMessages.getCashRegistersMessage(
                      'messageErrorClosingCashRegister',
                    ),
                    messageType: MessageType.error,
                  ),
                const SizedBox(height: 20),
                if (_bannerUpdateDateState.show)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTopBanner(
                      message: _bannerUpdateDateState.message,
                      type: _bannerUpdateDateState.type,
                      onClose: _closeBannerUpdateDate,
                    ),
                  ),
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
                        child:
                            BlocConsumer<
                              CashRegisterUpdateDateBloc,
                              CashRegisterUpdateDateState
                            >(
                              listener: (context, state) {
                                if (state
                                    is UpdateCashRegisterDateLoadSuccess) {
                                  _showTopBannerUpdateDate(
                                    'Fecha actualizada correctamente.',
                                    type: AppBannerType.success,
                                  );
                                }
                                if (state
                                    is UpdateCashRegisterDateLoadFailure) {
                                  _showTopBannerUpdateDate(
                                    state.message,
                                    type: AppBannerType.error,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is UpdateCashRegisterDateLoading) {
                                  return Text('Actualizando . .');
                                }
                                if (state
                                    is UpdateCashRegisterDateLoadSuccess) {
                                  _cashRegister = state.cashRegister;
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Fecha Caja:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      AppUtils.formatDate(
                                        _cashRegister.registerDate,
                                      ),
                                    ),
                                  ],
                                );
                              },
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
                              '\$ ${AppUtils.formatDouble(_cashRegister.openingAmount)}',
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
                                  return Text('Actualizando . .');
                                } else if (state
                                    is AvailableBalanceLoadSuccess) {
                                  return Text(
                                    '\$ ${AppUtils.formatDouble(state.availableBalance)}',
                                  );
                                } else if (state
                                    is AvailableBalanceLoadFailure) {
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
                    // Sales List
                    ExpansionPanelRadio(
                      value: 0,
                      headerBuilder: (context, isExpanded) =>
                          const ListTile(title: AppTitle(text: 'Ventas')),
                      body: Padding(
                        padding: AppConstants.gridPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!_readOnly)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: AppButton(
                                  title: 'Agregar Venta',
                                  onPressed: () async {
                                    _closeBannerSale();

                                    final repoPaymentMethod = context
                                        .read<PaymentMethodListBloc>();
                                    final paymentMethod =
                                        await repoPaymentMethod.paymentMethodDao
                                            .getPaymentMethodByName('Efectivo');
                                    Navigator.pushNamed(
                                      context,
                                      'new-sale',
                                      arguments: {
                                        'defaultSelectedPaymentMethod':
                                            paymentMethod,
                                        'cashRegisterId': _cashRegister.id,
                                      },
                                    );
                                  },
                                ),
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
                                          _cashRegister.id,
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
                                        // showFloatingEmoji(context, emoji: "👍");
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
                                      message: AppMessages.getSaleMessage(
                                        'messageLoadingSales',
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
                                        itemCount:
                                            state.sales.length +
                                            1, // sum + 1 to show extra total row
                                        itemBuilder: (context, index) {
                                          if (index < state.sales.length) {
                                            final sale = state.sales[index];
                                            return Column(
                                              children: [
                                                AppListItem(
                                                  title: Text(
                                                    sale.aliasProductName,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  description: Text(
                                                    'Cantidad: ${sale.quantity}',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  price: sale.totalPrice,
                                                  onEdit: !_readOnly
                                                      ? () async {
                                                          _closeBannerSale();
                                                          // get selected product
                                                          final repoProduct =
                                                              context
                                                                  .read<
                                                                    ProductsListBloc
                                                                  >();
                                                          final selectedProduct =
                                                              await repoProduct
                                                                  .productDao
                                                                  .getById(
                                                                    sale.productId,
                                                                  );

                                                          // get selected payment form
                                                          final repoPaymentMethod =
                                                              context
                                                                  .read<
                                                                    PaymentMethodListBloc
                                                                  >();
                                                          final selectedPaymentMethod =
                                                              await repoPaymentMethod
                                                                  .paymentMethodDao
                                                                  .getById(
                                                                    sale.paymentMethodId,
                                                                  );

                                                          // check if the sale is from subproduct
                                                          Purchase?
                                                          selectedPurchase;
                                                          if (sale.purchaseId !=
                                                              null) {
                                                            final repoPurchase =
                                                                context
                                                                    .read<
                                                                      PurchaseListBloc
                                                                    >();
                                                            selectedPurchase =
                                                                await repoPurchase
                                                                    .purchaseDao
                                                                    .getById(
                                                                      sale.purchaseId!,
                                                                    );
                                                          }

                                                          Navigator.pushNamed(
                                                            context,
                                                            'new-sale',
                                                            arguments: {
                                                              'selectedProduct':
                                                                  selectedProduct,
                                                              'selectedPaymentMethod':
                                                                  selectedPaymentMethod,
                                                              'sale': sale,
                                                              'selectedPurchase':
                                                                  selectedPurchase,
                                                              'cashRegisterId':
                                                                  _cashRegister
                                                                      .id,
                                                            },
                                                          );
                                                        }
                                                      : null,
                                                  onDelete: !_readOnly
                                                      ? () {
                                                          _showDeleteConfirmationSale(
                                                            context,
                                                            sale.id,
                                                          );
                                                        }
                                                      : null,
                                                ),
                                              ],
                                            );
                                          } else {
                                            // 👇 Este es el último ítem (el total)
                                            final total = state.sales
                                                .fold<double>(
                                                  0,
                                                  (sum, sale) =>
                                                      sum + sale.totalPrice,
                                                );

                                            return AppTotalFooter(
                                              total: total,
                                              label: 'Total',
                                            );
                                          }
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

                    // Purchases List
                    ExpansionPanelRadio(
                      value: 1,
                      headerBuilder: (context, isExpanded) =>
                          const ListTile(title: AppTitle(text: 'Compras')),

                      body: Padding(
                        padding: AppConstants.gridPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!_readOnly)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: AppButton(
                                  title: 'Agregar Compra',
                                  onPressed: () async {
                                    _closeBannerPurchase();
                                    final repoPaymentMethod = context
                                        .read<PaymentMethodListBloc>();
                                    final paymentMethod =
                                        await repoPaymentMethod.paymentMethodDao
                                            .getPaymentMethodByName('Efectivo');

                                    Navigator.pushNamed(
                                      context,
                                      'new-purchase',
                                      arguments: {
                                        'defaultSelectedPaymentMethod':
                                            paymentMethod,
                                        'cashRegisterId': _cashRegister.id,
                                      },
                                    );
                                  },
                                ),
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
                                BlocListener<
                                  PurchaseCrudBloc,
                                  PurchaseCrudState
                                >(
                                  listener: (context, state) {
                                    if (state is PurchaseDeletionSuccess) {
                                      _loadAvailableBalance();
                                      context.read<PurchaseListBloc>().add(
                                        LoadPurchasesListEvent(
                                          AppEventSource.list,
                                          _cashRegister.id,
                                        ),
                                      );
                                    }
                                    if (state is PurchaseDeletionFailure) {
                                      _showTopBannerPurchase(
                                        state.message,
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
                                BlocListener<
                                  PurchaseListBloc,
                                  PurchaseListState
                                >(
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
                              child: BlocBuilder<PurchaseListBloc, PurchaseListState>(
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
                                            onEdit: !_readOnly
                                                ? () async {
                                                    _closeBannerPurchase();
                                                    // get selected product
                                                    final repoProduct = context
                                                        .read<
                                                          ProductsListBloc
                                                        >();
                                                    final selectedProduct =
                                                        await repoProduct
                                                            .productDao
                                                            .getById(
                                                              purchase
                                                                  .productId,
                                                            );

                                                    // get selected payment form
                                                    final repoPaymentMethod =
                                                        context
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
                                                        'cashRegisterId':
                                                            _cashRegister.id,
                                                      },
                                                    );
                                                  }
                                                : null,
                                            onDelete: !_readOnly
                                                ? () {
                                                    _showDeleteConfirmationPurchase(
                                                      context,
                                                      purchase.id,
                                                    );
                                                  }
                                                : null,
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

                    // Expeses List
                    ExpansionPanelRadio(
                      value: 2,
                      headerBuilder: (context, isExpanded) =>
                          const ListTile(title: AppTitle(text: 'Gastos')),

                      body: Padding(
                        padding: AppConstants.gridPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!_readOnly)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: AppButton(
                                  title: 'Agregar Gasto',
                                  onPressed: () async {
                                    _closeBannerExpense();
                                    Navigator.pushNamed(
                                      context,
                                      'new-expense',
                                      arguments: {
                                        'cashRegisterId': _cashRegister.id,
                                      },
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 16),
                            if (_bannerExpenseState.show)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppTopBanner(
                                  message: _bannerExpenseState.message,
                                  type: _bannerExpenseState.type,
                                  onClose: _closeBannerExpense,
                                ),
                              ),
                            MultiBlocListener(
                              listeners: [
                                // Listener del bloc de creación/edición/eliminación
                                BlocListener<ExpenseCrudBloc, ExpenseCrudState>(
                                  listener: (context, state) {
                                    if (state is ExpenseDeletionSuccess) {
                                      _loadAvailableBalance();
                                      context.read<ExpenseListBloc>().add(
                                        LoadExpensesListEvent(
                                          AppEventSource.list,
                                          _cashRegister.id,
                                        ),
                                      );
                                    }
                                    if (state is ExpenseDeletionFailure) {
                                      _showTopBannerExpense(
                                        'Error al eliminar gasto',
                                        type: AppBannerType.error,
                                      );
                                    }
                                    if (state is ExpenseCreationSuccess) {
                                      _loadAvailableBalance();
                                    }
                                    if (state is ExpenseUpdateSuccess) {
                                      _loadAvailableBalance();
                                    }
                                  },
                                ),

                                // Listener de la lista
                                BlocListener<ExpenseListBloc, ExpenseListState>(
                                  listener: (context, state) {
                                    if (state is ExpensesListLoadSuccess) {
                                      if (state.eventSource ==
                                          AppEventSource.create) {
                                        _showTopBannerExpense(
                                          'Gasto creado con éxito',
                                        );
                                      } else if (state.eventSource ==
                                          AppEventSource.update) {
                                        _showTopBannerExpense(
                                          'Gasto actualizado con éxito',
                                        );
                                      } else if (state.eventSource ==
                                          AppEventSource.delete) {
                                        _showTopBannerExpense(
                                          'Gasto eliminado con éxito',
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                              child: BlocBuilder<ExpenseListBloc, ExpenseListState>(
                                builder: (context, state) {
                                  if (state is ExpensesListLoading) {
                                    return AppLoadingScreen(
                                      message: AppMessages.getExpenseMessage(
                                        'messageLoadingExpenses',
                                      ),
                                    );
                                  } else if (state is ExpensesListLoadSuccess) {
                                    if (state.expenses.isEmpty) {
                                      return AppSimpleCenterText(
                                        message: 'No hay información.',
                                      );
                                    } else {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.expenses.length,
                                        itemBuilder: (context, index) {
                                          final expense = state.expenses[index];
                                          return AppListItem(
                                            title: Text(
                                              expense.description,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            price: expense.amount,
                                            onEdit: !_readOnly
                                                ? () async {
                                                    _closeBannerExpense();

                                                    Navigator.pushNamed(
                                                      context,
                                                      'new-expense',
                                                      arguments: {
                                                        'expense': expense,
                                                        'cashRegisterId':
                                                            _cashRegister.id,
                                                      },
                                                    );
                                                  }
                                                : null,
                                            onDelete: !_readOnly
                                                ? () {
                                                    _showDeleteConfirmationExpense(
                                                      context,
                                                      expense.id,
                                                    );
                                                  }
                                                : null,
                                          );
                                        },
                                      );
                                    }
                                  } else if (state is ExpensesListLoadFailure) {
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

                    // Incomes List
                    ExpansionPanelRadio(
                      value: 3,
                      headerBuilder: (context, isExpanded) =>
                          const ListTile(title: AppTitle(text: 'Ingresos')),

                      body: Padding(
                        padding: AppConstants.gridPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!_readOnly)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: AppButton(
                                  title: 'Agregar Ingreso',
                                  onPressed: () async {
                                    _closeBannerIncome();
                                    Navigator.pushNamed(
                                      context,
                                      'new-income',
                                      arguments: {
                                        'cashRegisterId': _cashRegister.id,
                                      },
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 16),
                            if (_bannerIncomeState.show)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppTopBanner(
                                  message: _bannerIncomeState.message,
                                  type: _bannerIncomeState.type,
                                  onClose: _closeBannerIncome,
                                ),
                              ),
                            MultiBlocListener(
                              listeners: [
                                // Listener del bloc de creación/edición/eliminación
                                BlocListener<IncomeCrudBloc, IncomeCrudState>(
                                  listener: (context, state) {
                                    if (state is IncomeDeletionSuccess) {
                                      _loadAvailableBalance();
                                      context.read<IncomeListBloc>().add(
                                        LoadIncomesListEvent(
                                          AppEventSource.list,
                                          _cashRegister.id,
                                        ),
                                      );
                                    }
                                    if (state is IncomeDeletionFailure) {
                                      _showTopBannerIncome(
                                        'Error al eliminar ingreso',
                                        type: AppBannerType.error,
                                      );
                                    }
                                    if (state is IncomeCreationSuccess) {
                                      _loadAvailableBalance();
                                    }
                                    if (state is IncomeUpdateSuccess) {
                                      _loadAvailableBalance();
                                    }
                                  },
                                ),

                                // Listener de la lista
                                BlocListener<IncomeListBloc, IncomeListState>(
                                  listener: (context, state) {
                                    if (state is IncomesListLoadSuccess) {
                                      if (state.eventSource ==
                                          AppEventSource.create) {
                                        _showTopBannerIncome(
                                          'Ingreso creado con éxito',
                                        );
                                      } else if (state.eventSource ==
                                          AppEventSource.update) {
                                        _showTopBannerIncome(
                                          'Ingreso actualizado con éxito',
                                        );
                                      } else if (state.eventSource ==
                                          AppEventSource.delete) {
                                        _showTopBannerIncome(
                                          'Ingreso eliminado con éxito',
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                              child: BlocBuilder<IncomeListBloc, IncomeListState>(
                                builder: (context, state) {
                                  if (state is IncomesListLoading) {
                                    return AppLoadingScreen(
                                      message: AppMessages.getIncomeMessage(
                                        'messageLoadingIncomes',
                                      ),
                                    );
                                  } else if (state is IncomesListLoadSuccess) {
                                    if (state.incomes.isEmpty) {
                                      return AppSimpleCenterText(
                                        message: 'No hay información.',
                                      );
                                    } else {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.incomes.length,
                                        itemBuilder: (context, index) {
                                          final income = state.incomes[index];
                                          return AppListItem(
                                            title: Text(
                                              income.description,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            price: income.amount,
                                            onEdit: !_readOnly
                                                ? () async {
                                                    _closeBannerIncome();

                                                    Navigator.pushNamed(
                                                      context,
                                                      'new-income',
                                                      arguments: {
                                                        'income': income,
                                                        'cashRegisterId':
                                                            _cashRegister.id,
                                                      },
                                                    );
                                                  }
                                                : null,
                                            onDelete: !_readOnly
                                                ? () {
                                                    _showDeleteConfirmationIncome(
                                                      context,
                                                      income.id,
                                                    );
                                                  }
                                                : null,
                                          );
                                        },
                                      );
                                    }
                                  } else if (state is IncomesListLoadFailure) {
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
                      value: 4,
                      headerBuilder: (context, isExpanded) => const ListTile(
                        title: AppTitle(text: 'Ajustes de Inventario'),
                      ),
                      body: Padding(
                        padding: AppConstants.gridPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!_readOnly)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: AppButton(
                                  title: 'Agregar Ajuste',
                                  onPressed: () async {
                                    _closeBannerInventoryAdjustment();

                                    Navigator.pushNamed(
                                      context,
                                      'new-inventory-adjustment',
                                      arguments: {
                                        'cashRegisterId': _cashRegister.id,
                                      },
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 16),
                            if (_bannerInventoryAdjustmentState.show)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppTopBanner(
                                  message:
                                      _bannerInventoryAdjustmentState.message,
                                  type: _bannerInventoryAdjustmentState.type,
                                  onClose: _closeBannerInventoryAdjustment,
                                ),
                              ),
                            MultiBlocListener(
                              listeners: [
                                BlocListener<
                                  InventoryAdjustmentCrudBloc,
                                  InventoryAdjustmentCrudState
                                >(
                                  listener: (context, state) {
                                    if (state
                                        is InventoryAdjustmentDeletionSuccess) {
                                      context
                                          .read<InventoryAdjustmentListBloc>()
                                          .add(
                                            LoadInventoryAdjustmentListEvent(
                                              AppEventSource.list,
                                              _cashRegister.id,
                                            ),
                                          );
                                    }
                                    if (state
                                        is InventoryAdjustmentDeletionFailure) {
                                      _showTopBannerInventoryAdjustment(
                                        'Error al eliminar ajuste',
                                        type: AppBannerType.error,
                                      );
                                    }
                                  },
                                ),
                                BlocListener<
                                  InventoryAdjustmentListBloc,
                                  InventoryAdjustmentListState
                                >(
                                  listener: (context, state) {
                                    if (state
                                        is InventoryAdjustmentListLoadSuccess) {
                                      if (state.eventSource ==
                                          AppEventSource.create) {
                                        _showTopBannerInventoryAdjustment(
                                          'Ajuste creado con éxito',
                                        );
                                      } else if (state.eventSource ==
                                          AppEventSource.update) {
                                        _showTopBannerInventoryAdjustment(
                                          'Ajuste actualizado con éxito',
                                        );
                                      } else if (state.eventSource ==
                                          AppEventSource.delete) {
                                        _showTopBannerInventoryAdjustment(
                                          'Ajuste eliminado con éxito',
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                              child:
                                  BlocBuilder<
                                    InventoryAdjustmentListBloc,
                                    InventoryAdjustmentListState
                                  >(
                                    builder: (context, state) {
                                      if (state
                                          is InventoryAdjustmentListLoading) {
                                        return AppLoadingScreen(
                                          message:
                                              AppMessages.getInventoryAdjustmentMessage(
                                                'messageLoadingInventoryAdjustments',
                                              ),
                                        );
                                      } else if (state
                                          is InventoryAdjustmentListLoadSuccess) {
                                        if (state
                                            .inventoryAdjustments
                                            .isEmpty) {
                                          return AppSimpleCenterText(
                                            message: 'No hay información.',
                                          );
                                        } else {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                .inventoryAdjustments
                                                .length,
                                            itemBuilder: (context, index) {
                                              final inventoryAdjustment = state
                                                  .inventoryAdjustments[index];
                                              return AppListItem(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      inventoryAdjustment['productName'],
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    if (inventoryAdjustment['adjustmentTypeIncreasesStock'] ==
                                                        true)
                                                      Text(
                                                        '* ${inventoryAdjustment['adjustmentTypeName']} - Aumenta stock (${inventoryAdjustment['quantity']})',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    if (inventoryAdjustment['adjustmentTypeIncreasesStock'] ==
                                                        false)
                                                      Text(
                                                        '* ${inventoryAdjustment['adjustmentTypeName']} - Disminuye stock (${inventoryAdjustment['quantity']})',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.deepOrange,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                description: Text(
                                                  inventoryAdjustment['description'] ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                onEdit: !_readOnly
                                                    ? () async {
                                                        _closeBannerIncome();

                                                        // get selected product
                                                        final repoProduct =
                                                            context
                                                                .read<
                                                                  ProductsListBloc
                                                                >();
                                                        final selectedProduct =
                                                            await repoProduct
                                                                .productDao
                                                                .getById(
                                                                  inventoryAdjustment['productId'],
                                                                );

                                                        // get selected adjustment type
                                                        final repoAdjustmentType =
                                                            context
                                                                .read<
                                                                  InventoryAdjustmentListBloc
                                                                >();
                                                        final selectedAdjustmentType =
                                                            await repoAdjustmentType
                                                                .inventoryAdjustmentDao
                                                                .getById(
                                                                  inventoryAdjustment['adjustmentTypeId'],
                                                                );

                                                        Navigator.pushNamed(
                                                          context,
                                                          'new-inventory-adjustment',
                                                          arguments: {
                                                            'adjustment':
                                                                inventoryAdjustment,
                                                            'selectedProduct':
                                                                selectedProduct,
                                                            'selectedAdjustmentType':
                                                                selectedAdjustmentType,
                                                            'cashRegisterId':
                                                                _cashRegister
                                                                    .id,
                                                          },
                                                        );
                                                      }
                                                    : null,
                                                onDelete: !_readOnly
                                                    ? () {
                                                        _showDeleteConfirmationInventoryAdjustment(
                                                          context,
                                                          inventoryAdjustment['id'],
                                                        );
                                                      }
                                                    : null,
                                              );
                                            },
                                          );
                                        }
                                      } else if (state
                                          is InventoryAdjustmentListLoadFailure) {
                                        return const Center(
                                          child: Text(
                                            'Error al cargar ajustes de inventario',
                                          ),
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
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationPurchase(BuildContext context, int purchaseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que desea eliminar esta compra?',
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
          title: '¿Seguro que desea eliminar esta venta?',
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

  void _showDeleteConfirmationExpense(BuildContext context, int expenseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que desea eliminar este gasto?',
          content: 'Esta acción no se puede deshacer.',
          onCancel: () {
            // close dialog
          },
          onConfirm: () {
            // Acción de confirmar
            context.read<ExpenseCrudBloc>().add(DeleteExpenseEvent(expenseId));
          },
        );
      },
    );
  }

  void _showDeleteConfirmationIncome(BuildContext context, int expenseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que desea eliminar este ingreso?',
          content: 'Esta acción no se puede deshacer.',
          onCancel: () {
            // close dialog
          },
          onConfirm: () {
            // Acción de confirmar
            context.read<IncomeCrudBloc>().add(DeleteIncomeEvent(expenseId));
          },
        );
      },
    );
  }

  void _showDeleteConfirmationInventoryAdjustment(
    BuildContext context,
    int inventoryAdjustmentId,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que desea eliminar este ajuste de inventario?',
          content: 'Esta acción no se puede deshacer.',
          onCancel: () {
            // close dialog
          },
          onConfirm: () {
            // Acción de confirmar
            context.read<InventoryAdjustmentCrudBloc>().add(
              DeleteInventoryAdjustmentEvent(inventoryAdjustmentId),
            );
          },
        );
      },
    );
  }

  void _showConfirmationCloseCashRegister(
    BuildContext context,
    int cashRegisterId,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Seguro que desea cerrar esta caja?',
          content: 'Esta acción no se puede deshacer.',
          onCancel: () {
            // close dialog
          },
          onConfirm: () {
            // Acción de confirmar
            context.read<CashRegisterCloseBloc>().add(
              CloseCashRegisterEvent(cashRegisterId),
            );
          },
        );
      },
    );
  }

  void _showUpdateCashRegisterDateDialog(
    BuildContext context,
    CashRegister cashRegister,
  ) {
    final formKey = GlobalKey<FormState>();
    DateTime selectedDate = cashRegister.registerDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Actualizar Fecha de Caja'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Date selector
                    TextButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(AppUtils.formatDate(selectedDate)),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<CashRegisterUpdateDateBloc>().add(
                      UpdateCashRegisterDateEvent(
                        cashRegister.id,
                        AppUtils.formatDate(selectedDate),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Actualizar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
