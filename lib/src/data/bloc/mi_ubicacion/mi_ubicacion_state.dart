part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final LatLng latLng;
  final String address;
  final bool siguiendo;
  final bool ifLocationExist;

  MiUbicacionState({
    this.latLng,
    this.address,
    this.siguiendo = true,
    this.ifLocationExist = false,
  });

  MiUbicacionState copyWith({
    bool siguiendo,
    String address,
    LatLng latLng,
    bool existeUbicacion,
  }) =>
      new MiUbicacionState(
        latLng: latLng ?? this.latLng,
        address: address ?? this.address,
        siguiendo: siguiendo ?? this.siguiendo,
        ifLocationExist: existeUbicacion ?? this.ifLocationExist,
      );
}
