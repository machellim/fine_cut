import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fine_cut/core/enums/enums.dart';
import 'package:fine_cut/db/dao/inventory_adjustment_dao.dart';
import 'package:fine_cut/db/database.dart';

part 'inventory_adjustment_crud_event.dart';
part 'inventory_adjustment_crud_state.dart';

class InventoryAdjustmentCrudBloc
    extends Bloc<InventoryAdjustmentCrudEvent, InventoryAdjustmentCrudState> {
  final InventoryAdjustmentDao inventoryAdjustmentDao;
  InventoryAdjustmentCrudBloc({required this.inventoryAdjustmentDao})
    : super(InventoryAdjustmentCrudInitial()) {
    on<InventoryAdjustmentCrudEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
