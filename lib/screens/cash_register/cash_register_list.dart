import 'package:drift/drift.dart' as drift;
import 'package:fine_cut/bloc/cash_register/cash_register_can_edit/cash_register_can_edit_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_crud/cash_register_crud_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_data/cash_register_data_bloc.dart';
import 'package:fine_cut/bloc/cash_register/cash_register_list/cash_register_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/db/database.dart';
import 'package:fine_cut/widgets/app_alert_dialog.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_title_list_item.dart';
import 'package:fine_cut/widgets/app_top_banner.dart';
import 'package:intl/intl.dart';

import 'package:fine_cut/widgets/app_scaffold.dart';
import 'package:fine_cut/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashRegisterListScreen extends StatefulWidget {
  const CashRegisterListScreen({super.key});

  @override
  State<CashRegisterListScreen> createState() => _CashRegisterListScreenState();
}

class _CashRegisterListScreenState extends State<CashRegisterListScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CashRegisterListBloc>().add(
      LoadCashRegisterListEvent(AppEventSource.list),
    );
  }

  void _closeBanner() {
    context.read<CashRegisterCanEditBloc>().add(
      ResetCashRegisterCanEditEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarCustom(title: 'Historial de Cajas'),
      body: BlocConsumer<CashRegisterListBloc, CashRegisterListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CashRegisterListLoading) {
            return AppLoadingScreen(
              message: AppMessages.getCashRegistersMessage(
                'messageLoadingCashRegisters',
              ),
            );
          } else if (state is CashRegisterListLoadSuccess) {
            if (state.cashRegisters.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: AppMessages.getAppMessage('emptyList'),
                  messageType: MessageType.info,
                ),
              );
            }
            return Column(
              children: [
                BlocConsumer<CashRegisterCanEditBloc, CashRegisterCanEditState>(
                  listener: (context, state) => {
                    if (state is CashRegisterEditCheckLoadSuccess)
                      {
                        Navigator.pushNamed(
                          context,
                          'view-edit-cash-register',
                          arguments: {'cashRegister': state.cashRegister},
                        ),
                      },
                  },
                  builder: (context, state) {
                    if (state is CashRegisterEditCheckLoading) {
                      return AppCircularProgressText(
                        messageLoading: AppMessages.getCashRegistersMessage(
                          'messageLoadingEditCashRegister',
                        ),
                      );
                    } else if (state is CashRegisterEditCheckLoadFailure) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppTopBanner(
                          message: state.message,
                          type: AppBannerType.error,
                          onClose: _closeBanner,
                        ),
                      );
                    } else {
                      return Center();
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cashRegisters.length,
                    itemBuilder: (context, index) {
                      final cashRegister = state.cashRegisters[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppUtils.formatDate(
                                    cashRegister.registerDate,
                                  ),
                                ),
                                if (cashRegister.status ==
                                    CashRegisterStatus.open)
                                  Text(
                                    ' (Abierta)',
                                    style: (TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                    )),
                                  )
                                else
                                  Text(
                                    ' (Cerrada)',
                                    style: (TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                    )),
                                  ),
                              ],
                            ),
                            subtitle: (cashRegister.notes?.isNotEmpty == true)
                                ? Text(
                                    cashRegister.notes!,
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                : null,
                            leading: Icon(
                              cashRegister.status == CashRegisterStatus.open
                                  ? Icons
                                        .lock_open // caja abierta
                                  : Icons.lock, // caja cerrada
                              color:
                                  cashRegister.status == CashRegisterStatus.open
                                  ? Colors
                                        .green // verde si está abierta
                                  : Colors.redAccent, // rojo si está cerrada
                            ),
                            trailing:
                                (index == 0 ||
                                    cashRegister.status ==
                                        CashRegisterStatus.open)
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        tooltip: 'Editar',
                                        onPressed: () {
                                          if (cashRegister.status ==
                                              CashRegisterStatus.closed) {
                                            _showConfirmationReopenCashRegister(
                                              context,
                                              cashRegister,
                                            );
                                          } else {
                                            context
                                                .read<CashRegisterCanEditBloc>()
                                                .add(
                                                  CashRegisterEditCheckEvent(
                                                    cashRegister,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        tooltip: 'Ver',
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            'view-edit-cash-register',
                                            arguments: {
                                              'cashRegister': cashRegister,
                                              'readOnly': true,
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                          Divider(
                            color: Colors.grey, // Color de la línea
                            thickness: 0.4, // Grosor de la línea
                            indent: 4, // Espaciado desde la izquierda
                            endIndent: 4, // Espaciado desde la derecha
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is CashRegisterListLoadFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Estado desconocido'));
          }
        },
      ),
    );
  }

  void _showConfirmationReopenCashRegister(
    BuildContext context,
    CashRegister cashRegister,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: '¿Reabrir caja?',
          content:
              'Está a punto de reabrir esta caja cerrada.\n\n'
              'Podrá seguir registrando movimientos en ella.',
          onCancel: () {
            //Navigator.pop(context);
          },
          onConfirm: () {
            context.read<CashRegisterCanEditBloc>().add(
              CashRegisterEditCheckEvent(cashRegister, isReopen: true),
            );
            //Navigator.pop(context);
          },
        );
      },
    );
  }
}
