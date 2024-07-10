import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get font => Theme.of(this).textTheme;

  ColorScheme get color => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  Size get screenSize => MediaQuery.of(this).size;
}
