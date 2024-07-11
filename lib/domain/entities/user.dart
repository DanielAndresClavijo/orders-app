/// Clase base el usuario.
class User {
  final String userId;
  final String email;

  const User({
    required this.userId,
    required this.email,
  });

  @override
  String toString() {
    return "User{"
        "\n  userId: $userId,"
        "\n  email: $email"
        "\n}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          email == other.email;

  @override
  int get hashCode => userId.hashCode ^ email.hashCode;
}
