part of 'crear_producto_page_bloc.dart';

@immutable
abstract class CrearProductoPageEvent {}

class AddPathImageProduct extends CrearProductoPageEvent {
  final String pathImageProduct;

  AddPathImageProduct(this.pathImageProduct);
}

class AddIfDisponibilidad extends CrearProductoPageEvent {
  final bool ifDisponibilidad;

  AddIfDisponibilidad(this.ifDisponibilidad);
}

class AddNonbre extends CrearProductoPageEvent {
  final String nonbre;

  AddNonbre(this.nonbre);
}

class AddPrecio extends CrearProductoPageEvent {
  final String precio;

  AddPrecio(this.precio);
}

class AddCantidad extends CrearProductoPageEvent {
  final String cantidad;

  AddCantidad(this.cantidad);
}
