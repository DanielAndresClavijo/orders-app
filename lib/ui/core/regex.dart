RegExp passRegex = RegExp(
  /// Mínimo 2 caracteres consecutivos.
  r"^(?!.*(.)\1{2})"

  /// Mínimo 1 dígito.
  r"(?=(.*\d)+)"

  /// Mínimo 1 minuscula.
  r"(?=(.*[a-z])+)"

  /// Mínimo 1 mayúscula.
  r"(?=(.*[A-Z])+)"

  /// Mínimo 1 caracter especial.
  r"(?=(.*[@#$%!])+)"

  /// * 8-100 length
  r"[\da-zA-Z@#$%!]{8,100}$",
);

RegExp emailRegex = RegExp(
  r"^([A-Z|a-z0-9]([._])?)+"
  r"[A-Z|a-z0-9]"
  r"@([A-Z|a-z0-9])+"
  r"((\.)?[A-Z|a-z0-9]){2}"
  r"\.[a-z]{2,3}$",
);
