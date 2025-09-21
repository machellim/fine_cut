import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/inventory_adjustment_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'inventory_adjustment_list_event.dart';
part 'inventory_adjustment_list_state.dart';

class InventoryAdjustmentListBloc
    extends Bloc<InventoryAdjustmentListEvent, InventoryAdjustmentListState> {
  final InventoryAdjustmentDao inventoryAdjustmentDao;
  InventoryAdjustmentListBloc({required this.inventoryAdjustmentDao})
    : super(InventoryAdjustmentListInitial()) {
    on<InventoryAdjustmentListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
