part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final LatLng latLng;
  final LatLng initPosition;
  final AddressModel address;
  final bool siguiendo;
  final bool existeUbicacion;

  final Map<MarkerId, Marker> markers;

  MiUbicacionState({
    this.latLng,
    this.markers,
    this.address,
    this.initPosition,
    this.siguiendo = true,
    this.existeUbicacion = false,
  });

  MiUbicacionState copyWith({
    LatLng latLng,
    bool siguiendo,
    AddressModel address,
    LatLng initPosition,
    bool existeUbicacion,
    Map<MarkerId, Marker> markers,
  }) =>
      new MiUbicacionState(
        latLng: latLng ?? this.latLng,
        markers: markers ?? this.markers,
        address: address ?? this.address,
        siguiendo: siguiendo ?? this.siguiendo,
        initPosition: initPosition ?? this.initPosition,
        existeUbicacion: existeUbicacion ?? this.existeUbicacion,
      );
}
