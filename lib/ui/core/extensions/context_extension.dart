import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// Fuentes [TextTheme] de la app.
  TextTheme get font => Theme.of(this).textTheme;

  /// Colores [ColorScheme] de la app.
  ColorScheme get color => Theme.of(this).colorScheme;

  /// Información del tema [ThemeData] de la app.
  ThemeData get theme => Theme.of(this);

  /// Tamaño de la pantalla [Size] de la app.
  Size get screenSize => MediaQuery.of(this).size;
}