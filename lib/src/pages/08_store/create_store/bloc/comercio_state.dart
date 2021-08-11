part of 'comercio_bloc.dart';

@immutable
class ComercioState {
  final File latLng;
  final File icon;
  final bool ifView;
  final bool ifEnable;
  final bool ifVisible;
  final bool aceptoTerminos;
  final String nombreTipoDeTienda;
  final String pathTipoDeTienda;
  final BuildContext context;
  final List<LatLng> listOfLatLng;

  final Map<MarkerId, Marker> markers;

  ComercioState({
    this.icon,
    this.latLng,
    this.ifView,
    this.context,
    this.markers,
    this.ifEnable,
    this.ifVisible,
    this.listOfLatLng,
    this.aceptoTerminos,
    this.pathTipoDeTienda,
    this.nombreTipoDeTienda,
  });

  ComercioState copyWith({
    File icon,
    File latLng,
    bool ifView,
    bool ifEnable,
    bool ifVisible,
    bool aceptoTerminos,
    BuildContext context,
    String pathTipoDeTienda,
    List<LatLng> listOfLatLng,
    String nombreTipoDeTienda,
    Map<MarkerId, Marker> markers,
  }) =>
      ComercioState(
        icon: icon ?? this.icon,
        latLng: latLng ?? this.latLng,
        ifView: ifView ?? this.ifView,
        context: context ?? this.context,
        markers: markers ?? this.markers,
        ifEnable: ifEnable ?? this.ifEnable,
        ifVisible: ifVisible ?? this.ifVisible,
        listOfLatLng: listOfLatLng ?? this.listOfLatLng,
        aceptoTerminos: aceptoTerminos ?? this.aceptoTerminos,
        pathTipoDeTienda: pathTipoDeTienda ?? this.pathTipoDeTienda,
        nombreTipoDeTienda: nombreTipoDeTienda ?? this.nombreTipoDeTienda,
      );
}
