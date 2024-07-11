/// Clase de configuración de variables de la aplicación.
class AppConfig {
  /// Url para la conexion a la base de datos con supabase.
  final String supabaseUrl;

  /// Token de acceso a la base de datos con supabase.
  final String supabaseKey;

  /// Nombre de la tabla de la base de datos para los pedidos
  final String orderTableName;

  const AppConfig._({
    required this.supabaseUrl,
    required this.supabaseKey,
    required this.orderTableName,
  });

  /// Configura las variables de la aplicación.
  factory AppConfig.initialize() {
    return const AppConfig._(
      supabaseUrl: "",
      supabaseKey: "",
      orderTableName: "orders",
    );
  }
}
