part of 'crear_producto_page_bloc.dart';

@immutable
class CrearProductoState {
  final String pathImageProduct;
  final bool ifDisponibilidad;
  final String nonbre;
  final String precio;
  final String cantidad;

  CrearProductoState({
    this.pathImageProduct,
    this.ifDisponibilidad = true,
    this.nonbre,
    this.precio,
    this.cantidad,
  });

  CrearProductoState copyWith({
    String pathImageProduct,
    bool ifDisponibilidad,
    String nonbre,
    String precio,
    String cantidad,
  }) =>
      CrearProductoState(
        precio: precio ?? this.precio,
        nonbre: nonbre ?? this.nonbre,
        cantidad: cantidad ?? this.cantidad,
        pathImageProduct: pathImageProduct ?? this.pathImageProduct,
        ifDisponibilidad: ifDisponibilidad ?? this.ifDisponibilidad,
      );
}
