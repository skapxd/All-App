part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final LatLng latLng;
  final LatLng initPosition;
  final List<String> address;
  final bool siguiendo;
  final bool ifLocationExist;

  MiUbicacionState({
    this.latLng,
    this.address,
    this.initPosition,
    this.siguiendo = true,
    this.ifLocationExist = false,
  });

  MiUbicacionState copyWith({
    LatLng latLng,
    bool siguiendo,
    LatLng initPosition,
    List<String> address,
    bool existeUbicacion,
  }) =>
      new MiUbicacionState(
        latLng: latLng ?? this.latLng,
        address: address ?? this.address,
        siguiendo: siguiendo ?? this.siguiendo,
        initPosition: initPosition ?? this.initPosition,
        ifLocationExist: existeUbicacion ?? this.ifLocationExist,
      );
}
