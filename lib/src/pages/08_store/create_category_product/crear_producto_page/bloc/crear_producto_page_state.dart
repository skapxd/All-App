part of 'crear_producto_page_bloc.dart';

@immutable
class CrearProductoState {
  final String pathImageProduct;
  final bool ifDisponibilidad;
  final String nonbre;
  final String precio;
  final String cantidad;

  final ListProduct listProduct;

  final Map<int, bool> mapToggleColor;

  CrearProductoState({
    this.pathImageProduct,
    this.ifDisponibilidad = true,
    this.nonbre,
    this.precio,
    this.cantidad,
    this.listProduct,
    this.mapToggleColor = const {},
  });

  CrearProductoState copyWith({
    String pathImageProduct,
    bool ifDisponibilidad,
    String nonbre,
    String precio,
    String cantidad,
    ListProduct listProduct,
    Map<int, bool> mapToggleColor,
  }) =>
      CrearProductoState(
        precio: precio ?? this.precio,
        nonbre: nonbre ?? this.nonbre,
        cantidad: cantidad ?? this.cantidad,
        listProduct: listProduct ?? this.listProduct,
        pathImageProduct: pathImageProduct ?? this.pathImageProduct,
        ifDisponibilidad: ifDisponibilidad ?? this.ifDisponibilidad,
        mapToggleColor: mapToggleColor ?? this.mapToggleColor,
      );
}
