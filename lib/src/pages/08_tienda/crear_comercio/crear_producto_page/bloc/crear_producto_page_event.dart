part of 'crear_producto_page_bloc.dart';

@immutable
abstract class CrearProductoEvent {}

class AddPathImageProduct extends CrearProductoEvent {
  final String pathImageProduct;

  AddPathImageProduct(this.pathImageProduct);
}

class AddIfDisponibilidad extends CrearProductoEvent {
  final bool ifDisponibilidad;

  AddIfDisponibilidad(this.ifDisponibilidad);
}

class AddNonbre extends CrearProductoEvent {
  final String nonbre;

  AddNonbre(this.nonbre);
}

class AddPrecio extends CrearProductoEvent {
  final String precio;

  AddPrecio(this.precio);
}

class AddCantidad extends CrearProductoEvent {
  final String cantidad;

  AddCantidad(this.cantidad);
}
