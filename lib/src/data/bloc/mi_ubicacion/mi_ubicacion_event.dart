part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class AddUbicacion extends MiUbicacionEvent {
  final LatLng position;

  AddUbicacion(this.position);
}
