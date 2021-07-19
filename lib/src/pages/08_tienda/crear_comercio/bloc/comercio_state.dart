part of 'comercio_bloc.dart';

@immutable
class ComercioState {
  final File latLng;
  final File icon;
  final bool ifView;
  final bool ifEnable;
  final bool aceptoTerminos;
  final String nombreTipoDeTienda;
  final String pathTipoDeTienda;

  final Map<MarkerId, Marker> markers;

  ComercioState({
    this.icon,
    this.latLng,
    this.ifView,
    this.markers,
    this.ifEnable,
    this.aceptoTerminos,
    this.pathTipoDeTienda,
    this.nombreTipoDeTienda,
  });

  ComercioState copyWith({
    File icon,
    File latLng,
    bool ifView,
    bool ifEnable,
    bool aceptoTerminos,
    String pathTipoDeTienda,
    String nombreTipoDeTienda,
    Map<MarkerId, Marker> markers,
  }) =>
      ComercioState(
        icon: icon ?? this.icon,
        latLng: latLng ?? this.latLng,
        ifView: ifView ?? this.ifView,
        markers: markers ?? this.markers,
        ifEnable: ifEnable ?? this.ifEnable,
        aceptoTerminos: aceptoTerminos ?? this.aceptoTerminos,
        pathTipoDeTienda: pathTipoDeTienda ?? this.pathTipoDeTienda,
        nombreTipoDeTienda: nombreTipoDeTienda ?? this.nombreTipoDeTienda,
      );
}
