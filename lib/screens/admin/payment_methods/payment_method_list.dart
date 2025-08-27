import 'package:fine_cut/bloc/payment_method/payment_method_bloc.dart';
import 'package:fine_cut/constants/app_messages.dart';
import 'package:fine_cut/db/enums.dart';
import 'package:fine_cut/widgets/app_circular_progress_text.dart';
import 'package:fine_cut/widgets/app_description_list_item.dart';
import 'package:fine_cut/widgets/app_floating_action_button.dart';
import 'package:fine_cut/widgets/app_list_item.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_title_list_item.dart' hide AppActiveStatus;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodListScreen extends StatefulWidget {
  const PaymentMethodListScreen({super.key});

  @override
  State<PaymentMethodListScreen> createState() =>
      _PaymentMethodListScreenState();
}

class _PaymentMethodListScreenState extends State<PaymentMethodListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodBloc>().add(LoadPaymentMethodsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Categorías")),
      body: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        builder: (context, state) {
          if (state is PaymentMethodsLoading) {
            return AppLoadingScreen(
              message: AppMessages.getPaymentMethodMessage(
                'messageLoadingPaymentMethods',
              ),
            );
          } else if (state is PaymentMethodsLoadSuccess) {
            return ListView.builder(
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
                            : Theme.of(context).colorScheme.primary.withValues(
                                alpha: 0.3,
                              ), // más tenue
                        child: Text(
                          '${state.paymentMethods[index].displayOrder}',
                          style: TextStyle(
                            color:
                                state.paymentMethods[index].status ==
                                    AppActiveStatus.active
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(
                                    context,
                                  ).colorScheme.onPrimary.withValues(
                                    alpha: 0.3,
                                  ), // texto más tenue
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: AppTitleListItem(
                        text: state.paymentMethods[index].name,
                        status: state.paymentMethods[index].status.name,
                      ),

                      description: AppDescriptionListItem(
                        text: state.paymentMethods[index].description ?? '',
                        status: state.paymentMethods[index].status.name,
                      ),
                      onEdit: () {
                        Navigator.pushNamed(
                          context,
                          'new-category',
                          arguments: state.paymentMethods[index],
                        );
                      },
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
          await Navigator.pushNamed(context, 'new-category');
        },
        tooltip: 'Agregar Categoría',
        icon: Icons.add,
      ),
    );
  }
}
