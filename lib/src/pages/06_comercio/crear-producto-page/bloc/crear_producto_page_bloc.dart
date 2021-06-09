import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'crear_producto_page_event.dart';
part 'crear_producto_page_state.dart';

class CrearProductoPageBloc
    extends Bloc<CrearProductoPageEvent, CrearProductoPageState> {
  CrearProductoPageBloc() : super(CrearProductoPageState());

  @override
  Stream<CrearProductoPageState> mapEventToState(
    CrearProductoPageEvent event,
  ) async* {
    if (event is AddPathImageProduct) {
      //

      yield state.copyWith(pathImageProduct: event.pathImageProduct);
    }

    if (event is AddIfDisponibilidad) {
      //

      yield state.copyWith(ifDisponibilidad: event.ifDisponibilidad);
    }

    if (event is AddNonbre) {
      //

      yield state.copyWith(nonbre: event.nonbre);
    }

    if (event is AddPrecio) {
      //

      yield state.copyWith(precio: event.precio);
    }

    if (event is AddCantidad) {
      //

      yield state.copyWith(cantidad: event.cantidad);
    }
  }
}
