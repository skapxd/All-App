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

class CreateProduct extends CrearProductoEvent {
  final String name;
  final String price;
  final String quantity;
  final String category;
  final String urlImageProductStore;

  CreateProduct({
    @required this.name,
    @required this.price,
    @required this.quantity,
    @required this.category,
    @required this.urlImageProductStore,
  });
}

class MapToggleColor extends CrearProductoEvent {
  final Map<int, bool> mapToggleColor;
  MapToggleColor(this.mapToggleColor);
}

class DeleteGroupCategories extends CrearProductoEvent {
  final List<int> groupCategories;

  DeleteGroupCategories(this.groupCategories);
}
