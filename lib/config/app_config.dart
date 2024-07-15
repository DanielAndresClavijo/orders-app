/// El entorno con la que se va a trabajar el cliente.
///
///  - [fromMock] Desde mocks como fuente de datos
///  - [fromBaaS] Desde un Backend as a Service. Ej: Supabase, Firebase, Appwrite, etc.
enum ClientEnvironment { fromMock, fromBaaS }

/// Clase de configuración de variables de la aplicación.
class AppConfig {
  /// Url para la conexión a la base de datos con supabase.
  final String supabaseUrl;

  /// Token de acceso a la base de datos con supabase.
  final String supabaseKey;

  /// Nombre de la tabla de la base de datos para los pedidos
  final String orderTableName;

  /// Para saber que entorno va a utilizar el cliente como fuente de datos.
  final ClientEnvironment clientEnvironment;

  const AppConfig._({
    required this.clientEnvironment,
    required this.supabaseUrl,
    required this.supabaseKey,
    required this.orderTableName,
  });

  /// Configura las variables de la aplicación.
  factory AppConfig.initialize() {
    return const AppConfig._(
      clientEnvironment: ClientEnvironment.fromMock,
      supabaseUrl: "https://trracpsdbbntajgygbla.supabase.co",
      supabaseKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRycmFjcHNkYmJudGFqZ3lnYmxhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA0NzU5NDAsImV4cCI6MjAzNjA1MTk0MH0.uJ-iKjHZ3Zy-lNSo9L1YpMiyFizStFhHHPWDfMvsefA",
      orderTableName: "orders",
    );
  }
}
