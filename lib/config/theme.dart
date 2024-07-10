import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Color kDarkColorApp = Color(0xFF1C1C1C);
const Color kWhiteColorApp = Color(0xFFFFFFFF);
const Color kSeedColorApp = Color(0xFF00A877);

ThemeData appTheme(bool isDarkMode) => ThemeData(
      // primaryColor:
      colorScheme: ColorScheme.fromSeed(
        seedColor: isDarkMode ? kWhiteColorApp : kDarkColorApp,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      scaffoldBackgroundColor:
          isDarkMode ? kDarkColorApp : const Color(0xFFF8F8F8),
      cardColor: isDarkMode ? const Color(0xFF2C2C2C) : kWhiteColorApp,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? kWhiteColorApp : kDarkColorApp,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? kWhiteColorApp : kDarkColorApp,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: isDarkMode ? kWhiteColorApp : kDarkColorApp,
        ),
        titleMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: kSeedColorApp,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? const Color(0xFFA1A1A1) : const Color(0xFFFF4D4D),
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

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});
