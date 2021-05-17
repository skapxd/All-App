part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final bool siguiendo;
  final bool ifLocationExist;
  final LatLng ubicacion;

  MiUbicacionState({
    this.siguiendo = true,
    this.ifLocationExist = false,
    this.ubicacion,
  });

  MiUbicacionState copyWith({
    bool siguiendo,
    bool existeUbicacion,
    LatLng ubicacion,
  }) =>
      new MiUbicacionState(
        siguiendo: siguiendo ?? this.siguiendo,
        ifLocationExist: existeUbicacion ?? this.ifLocationExist,
        ubicacion: ubicacion ?? this.ubicacion,
      );
}
