extension DateTimeExtension on DateTime {
  /// Texto de mes y día.
  ///
  /// formato: "Abr 12", "Ene 12"...
  String get monthAndDayText {
    return "${monthText.substring(0, 3)} $day";
  }

  /// Texto del mes
  ///
  /// formato: 1 -> "Enero", 2 -> "Febrero"...
  String get monthText {
    switch (month) {
      case DateTime.january:
        return "Enero";
      case DateTime.february:
        return "Febrero";
      case DateTime.march:
        return "Marzo";
      case DateTime.april:
        return "Abril";
      case DateTime.may:
        return "Mayo";
      case DateTime.june:
        return "Junio";
      case DateTime.july:
        return "Julio";
      case DateTime.august:
        return "Agosto";
      case DateTime.september:
        return "Septiembre";
      case DateTime.october:
        return "Octubre";
      case DateTime.november:
        return "Noviembre";
      case DateTime.december:
      default:
        return "Diciembre";
    }
  }
}
