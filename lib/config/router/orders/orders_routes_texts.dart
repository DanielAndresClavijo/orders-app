part of 'orders_routes.dart';

/// Path inicial para las rutas de pedidos.
///
///
///  __Ruta `/orders`__
const String kOrderBasePath = "/orders";

/// Sub-path para la ruta de listado de pedidos.
///
/// Nota: El sub-path es utilizado por GoRoute para las rutas anidadas.
const String _kOrderListSubPath = "list";

/// # Ruta para navegar al listado de pedidos.
///
///  __Ruta `/orders/list`__
const String kOrdersListPath = "$kOrderBasePath/$_kOrderListSubPath";

/// # Nombre de Ruta para navegar al listado de pedidos.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `ordersPathName`__
const String kOrdersListPathName = "ordersPathName";

/// Sub-path para la ruta del detalle de pedido.
///
/// Nota: El sub-path es utilizado por GoRoute para las rutas anidadas.
const String _kOrderDetailSubPath = "detail";

/// # Ruta para navegar al detalle del pedido.
///
///  Nota: Es necesario agregar el id del pedido al final de la ruta precedido
///  de `/`. Ej: `orders/detail/123`
///
///  __Ruta `/orders/detail`__
const String kOrderDetailPath = "$kOrderBasePath/$_kOrderDetailSubPath";

/// # Nombre de Ruta para navegar al detalle de algun pedido.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `orderDetailPathName`__
const String kOrderDetailPathName = "orderDetailPathName";