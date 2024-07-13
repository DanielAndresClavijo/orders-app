import 'package:flutter/material.dart';

const Color kDarkColorApp = Color(0xFF333333);
const Color kWhiteColorApp = Color(0xFFF5F5F5);
const Color kSeedColorApp = Color(0xFF00A877);

ThemeData appTheme(bool isDarkMode) {
  return ThemeData(
    fontFamily: "Poppins",
    primaryColor: kDarkColorApp,
    colorScheme: ColorScheme.fromSeed(
      seedColor: isDarkMode ? kWhiteColorApp : kDarkColorApp,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      error: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFFFE6F2),
      onError: isDarkMode ? const Color(0xFFAD1457) : const Color(0xFFE91E63),
    ),
    scaffoldBackgroundColor: isDarkMode ? kDarkColorApp : kWhiteColorApp,
    cardColor: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFFFFFFF),
    textTheme: const TextTheme(
      // Para el título principal "Historial"
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      // Para el nombre del restaurante "Boston’s Pizza" Facturacion
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      // Para el nombre del restaurante "Habibi" y
      // para el título de la sección "Tu pedido"
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      // Para el subtítulo "Pedidos anteriores"
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      // Para la información del pedido "3 artículos · \$480.00\nDyshesz Direct\nAbr 13 · Completado"
      // Para el texto de los artículos del pedido "Reserva de Promo Live"
      // Para el nombre del banco y el número de tarjeta "ICICI Bank Card ****5486"
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      // Para los detalles del pedido "Tu pedido", "Pizza italiana",
      // "Rebanada de pastel de chocolate", "Refresco de 1 Lt"
      // Para "Total pagado" y su monto "$0.00"
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      // Para los precios tachados y Para el monto total de los artículos "$0.00"
      // Para el botón "Ver factura"
      // Para el botón "¿Necesitas ayuda?"
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // Para los descuentos y para el estado del pedido "Presentado"
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // Para los precios descontados
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      // Para el total de los artículos y otros totales
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkMode ? kDarkColorApp : kWhiteColorApp,
      foregroundColor: isDarkMode ? kWhiteColorApp : kDarkColorApp,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? kWhiteColorApp : kDarkColorApp,
      ),
    ),
    iconTheme: const IconThemeData(
      color: kDarkColorApp,
    ),
    dividerColor: const Color(0xFFE0E0E0),
  );
}

class ThemeNotifier extends ChangeNotifier {
  ThemeData theme = appTheme(false);

  ThemeNotifier();

  bool get isDarkMode => theme.brightness == Brightness.dark;

  void toggleTheme() {
    if (theme.brightness == Brightness.dark) {
      theme = appTheme(false);
    } else {
      theme = appTheme(true);
    }
    notifyListeners();
  }
}
