import 'package:fine_cut/bloc/payment_method/payment_method_list/payment_method_list_bloc.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/widgets/app_description_list_item.dart';
import 'package:fine_cut/widgets/app_floating_action_button.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:fine_cut/widgets/app_title_list_item.dart';
import 'package:fine_cut/widgets/app_top_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodListScreen extends StatefulWidget {
  const PaymentMethodListScreen({super.key});

  @override
  State<PaymentMethodListScreen> createState() =>
      _PaymentMethodListScreenState();
}

class _PaymentMethodListScreenState extends State<PaymentMethodListScreen> {
  bool _showBanner = false;
  String _bannerMessage = '';

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodListBloc>().add(
      LoadPaymentMethodsEvent(AppEventSource.list),
    );
  }

  void _showTopBanner(String message) {
    setState(() {
      _showBanner = true;
      _bannerMessage = message;
    });
  }

  void _closeBanner() {
    setState(() {
      _showBanner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formas de Pago")),
      body: BlocConsumer<PaymentMethodListBloc, PaymentMethodListState>(
        listener: (context, state) => {
          if (state is PaymentMethodsLoadSuccess)
            {
              if (state.eventSource == AppEventSource.create)
                {_showTopBanner('Forma de Pago creada con éxito')}
              else if (state.eventSource == AppEventSource.update)
                {_showTopBanner('Forma de Pago actualizada con éxito')},
            },
        },
        builder: (context, state) {
          if (state is PaymentMethodsLoading) {
            return AppLoadingScreen(
              message: AppMessages.getPaymentMethodMessage(
                'messageLoadingPaymentMethods',
              ),
            );
          } else if (state is PaymentMethodsLoadSuccess) {
            if (state.paymentMethods.isEmpty) {
              return Center(
                child: AppMessageType(
                  message: AppMessages.getAppMessage('emptyList'),
                  messageType: MessageType.info,
                ),
              );
            }
            return Column(
              children: [
                if (_showBanner)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTopBanner(
                      message: _bannerMessage,
                      type: AppBannerType.success,
                      onClose: _closeBanner,
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.paymentMethods.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AppListItem(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  state.paymentMethods[index].status ==
                                      AppActiveStatus.active
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.3),
                              child: Text(
                                '${state.paymentMethods[index].displayOrder}',
                                style: TextStyle(
                                  color:
                                      state.paymentMethods[index].status ==
                                          AppActiveStatus.active
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onPrimary
                                            .withValues(alpha: 0.3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: AppTitleListItem(
                              text: state.paymentMethods[index].name,
                              status: state.paymentMethods[index].status.name,
                            ),
                            description: AppDescriptionListItem(
                              text:
                                  state.paymentMethods[index].description ?? '',
                              status: state.paymentMethods[index].status.name,
                            ),
                            onEdit: () {
                              Navigator.pushNamed(
                                context,
                                'new-payment-method',
                                arguments: state.paymentMethods[index],
                              );
                            },
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.4,
                            indent: 4,
                            endIndent: 4,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PaymentMethodsLoadFailure) {
            return Center(
              child: Text(
                AppMessages.getPaymentMethodMessage(
                  'messageLoadFailurePaymentMethods',
                ),
              ),
            );
          } else {
            return Center(child: Text('Estado desconocido'));
          }
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'new-payment-method');
        },
        tooltip: 'Agregar Forma de Pago',
        icon: Icons.add,
      ),
    );
  }
}
