class AppMessages {
  static const _paymentMethodMessages = {
    'messageLoadingPaymentMethods': 'Cargando Formas de pago',
    'messageLoadFailurePaymentMethods': 'Error al cargar Formas de Pago',
  };

  static String getPaymentMethodMessage(String key) {
    return _paymentMethodMessages[key] ?? 'mensaje no parametrizado';
  }
}
