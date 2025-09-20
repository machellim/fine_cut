import 'package:fine_cut/bloc/category/categories_list/categories_list_bloc.dart';
import 'package:fine_cut/bloc/purchase/parent_product_stock/parent_product_stock_bloc.dart';
import 'package:fine_cut/bloc/reports/product_profit_list/product_profit_list_bloc.dart';
import 'package:fine_cut/core/constants/app_constants.dart';
import 'package:fine_cut/core/constants/app_messages.dart';
import 'package:fine_cut/core/utils/helpers.dart';
import 'package:fine_cut/widgets/app_badge_status.dart';
import 'package:fine_cut/widgets/app_bar_custom.dart';
import 'package:fine_cut/widgets/app_button.dart';
import 'package:fine_cut/widgets/app_date_field.dart';
import 'package:fine_cut/widgets/app_loading_screen.dart';
import 'package:fine_cut/widgets/app_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductProfitListScreen extends StatefulWidget {
  const ProductProfitListScreen({super.key});

  @override
  State<ProductProfitListScreen> createState() =>
      _ProductProfitListScreenState();
}

class _ProductProfitListScreenState extends State<ProductProfitListScreen> {
  final _formKey = GlobalKey<FormState>();
  String _startDate = AppUtils.formatDateTimeYMD(DateTime.now());
  String _endDate = AppUtils.formatDateTimeYMD(DateTime.now());

  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController(text: _startDate);
    _endDateController = TextEditingController(text: _endDate);

    context.read<ProductProfitListBloc>().add(
      LoadProductProfitListEvent(startDate: _startDate, endDate: _endDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Ganancias por Producto"),
      body: BlocBuilder<ProductProfitListBloc, ProductProfitListState>(
        builder: (context, state) {
          final isLoading = state is ProductProfitListLoading;

          return SingleChildScrollView(
            padding: AppConstants.screenPadding,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Fecha inicio
                      AppDateField(
                        label: "Fecha Inicio",
                        controller: _startDateController,
                        lastDate: DateTime.now(),
                        onDateSelected: (date) {
                          _startDateController.text =
                              AppUtils.formatDateTimeYMD(date);
                          _startDate = AppUtils.formatDateTimeYMD(date);
                        },
                        validate: true,
                        validationMessage: "Selecciona una fecha",
                      ),
                      const SizedBox(height: 24),

                      // Fecha fin
                      AppDateField(
                        label: "Fecha Fin",
                        controller: _endDateController,
                        lastDate: DateTime.now(),
                        onDateSelected: (date) {
                          _endDateController.text = AppUtils.formatDateTimeYMD(
                            date,
                          );
                          _endDate = AppUtils.formatDateTimeYMD(date);
                        },
                        validate: true,
                        validationMessage: "Selecciona una fecha",
                      ),
                      const SizedBox(height: 24),

                      // Botón filtrar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 32.0,
                        ),
                        child: AppButton(
                          title: 'Filtrar',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    context.read<ProductProfitListBloc>().add(
                                      LoadProductProfitListEvent(
                                        startDate: _startDate,
                                        endDate: _endDate,
                                      ),
                                    );
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Estados del bloc
                if (state is ProductProfitListLoading)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: AppLoadingScreen(
                      message: AppMessages.getProductProfitMessage(
                        'messageLoadingProductProfit',
                      ),
                    ),
                  ),

                if (state is ProductProfitListFailure)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: AppMessageType(
                        message: state.message,
                        messageType: MessageType.error,
                      ),
                    ),
                  ),

                if (state is ProductProfitListSuccess &&
                    state.productProfitList.isEmpty)
                  SizedBox(
                    child: Center(
                      child: AppMessageType(
                        message: AppMessages.getAppMessage('emptyList'),
                        messageType: MessageType.info,
                      ),
                    ),
                  ),

                if (state is ProductProfitListSuccess)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.productProfitList.length,
                    itemBuilder: (context, index) {
                      final productProfit = state.productProfitList[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              productProfit.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cantidad vendida: ${productProfit.totalQuantitySold}",
                                ),
                                Text(
                                  "Total ventas: \$${productProfit.totalSales.toStringAsFixed(2)}",
                                ),
                                Text(
                                  "Costo promedio: \$${productProfit.avgCost.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Ganancia",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  "\$${productProfit.profit.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
