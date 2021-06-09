part of 'crear_producto_page_bloc.dart';

@immutable
class CrearProductoPageState {
  final String pathImageProduct;
  final bool ifDisponibilidad;
  final String nonbre;
  final String precio;
  final String cantidad;

  CrearProductoPageState({
    this.pathImageProduct,
    this.ifDisponibilidad = true,
    this.nonbre,
    this.precio,
    this.cantidad,
  });

  CrearProductoPageState copyWith({
    String pathImageProduct,
    bool ifDisponibilidad,
    String nonbre,
    String precio,
    String cantidad,
  }) =>
      CrearProductoPageState(
        precio: precio ?? this.precio,
        nonbre: nonbre ?? this.nonbre,
        cantidad: cantidad ?? this.cantidad,
        pathImageProduct: pathImageProduct ?? this.pathImageProduct,
        ifDisponibilidad: ifDisponibilidad ?? this.ifDisponibilidad,
      );
}
