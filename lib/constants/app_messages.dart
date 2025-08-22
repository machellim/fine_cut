class AppMessages {
  static const Map<String, String> loginMessages = {
    'titleHomeScreen': 'Resumen Financiero',
  };

  static String getMessage(Map<String, String> messageCategory, String key) {
    return messageCategory[key] ?? 'mensaje no parametrizado';
  }
}
