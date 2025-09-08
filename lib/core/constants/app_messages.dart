class AppMessages {
  static const _paymentMethodMessages = {
    'messageLoadingPaymentMethods': 'Cargando Formas de pago',
    'messageLoadFailurePaymentMethods': 'Error al cargar Formas de Pago',
  };

  static const _cashRegisterMessages = {
    'messageLoadingDataCashRegisters': 'Cargando informacion de última caja.',
    'messageLoadFailureDataCashRegisters':
        'Error al cargar información de última caja.',
    'messageClosingCashRegister': 'Cerrando caja',
    'messageErrorClosingCashRegister': 'Error al cerrar la caja.',
    'messageLoadingCashRegisters': 'Cargando historial de cajas.',
    'messageLoadingEditCashRegister': 'Editando Caja.',
    'messageLoadingCashRegisterLastClosed': 'Obteniendo información.',
  };

  static const _categoryMessages = {
    'messageLoadingCategories': 'Cargando categorías.',
  };

  static const _productMessages = {
    'messageNewProductScreen': 'Crear Nuevo Producto.',
    'messageEditProductScreen': 'Editar Producto.',
    'messageLoadingProducts': 'Cargando productos.',
  };

  static const _saleMessages = {
    'messageNewSaleScreen': 'Crear Nueva Venta',
    'messageEditSaleScreen': 'Editar Venta',
    'messageLoadingSales': 'Cargando ventas',
  };

  static const _purchaseMessages = {
    'messageNewPurchaseScreen': 'Crear Nueva Compra',
    'messageEditPurchaseScreen': 'Editando Compra',
    'messageLoadingPurchase': 'Cargando compras',
  };

  static const _expenseMessages = {
    'messageLoadingExpenses': 'Cargando gastos',
    'messageNewExpenseScreen': 'Crear Nuevo Gasto',
    'messageEditExpenseScreen': 'Editando gasto',
  };

  static const appMessages = {'emptyList': 'No hay información.'};

  static String getPaymentMethodMessage(String key) {
    return _paymentMethodMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getCashRegistersMessage(String key) {
    return _cashRegisterMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getCategoryMessage(String key) {
    return _categoryMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getProductMessage(String key) {
    return _productMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getAppMessage(String key) {
    return appMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getSaleMessage(String key) {
    return _saleMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getPurchaseMessage(String key) {
    return _purchaseMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getExpenseMessage(String key) {
    return _expenseMessages[key] ?? 'mensaje no parametrizado';
  }
}
