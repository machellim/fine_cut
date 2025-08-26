class AppMessages {
  static const _paymentMethodMessages = {
    'messageLoadingPaymentMethods': 'Cargando Formas de pago',
    'messageLoadFailurePaymentMethods': 'Error al cargar Formas de Pago',
  };

  static const _cashRegisterMessages = {
    'messageLoadingDataCashRegisters': 'Cargando informacion de última caja.',
    'messageLoadFailureDataCashRegisters':
        'Error al cargar información de última caja.',
  };

  static String getPaymentMethodMessage(String key) {
    return _paymentMethodMessages[key] ?? 'mensaje no parametrizado';
  }

  static String getDataCashRegistersMessage(String key) {
    return _cashRegisterMessages[key] ?? 'mensaje no parametrizado';
  }
}
