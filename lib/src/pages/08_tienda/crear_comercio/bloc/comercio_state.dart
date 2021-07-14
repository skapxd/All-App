part of 'comercio_bloc.dart';

@immutable
class ComercioState {
  final File icon;
  final bool ifView;
  final bool ifEnable;
  final bool aceptoTerminos;
  final String nombreTipoDeTienda;
  final String pathTipoDeTienda;

  ComercioState({
    this.icon,
    this.ifView,
    this.ifEnable,
    this.aceptoTerminos,
    this.pathTipoDeTienda,
    this.nombreTipoDeTienda,
  });

  ComercioState copyWith({
    File icon,
    bool ifView,
    bool ifEnable,
    bool aceptoTerminos,
    String pathTipoDeTienda,
    String nombreTipoDeTienda,
  }) =>
      ComercioState(
        icon: icon ?? this.icon,
        ifView: ifView ?? this.ifView,
        ifEnable: ifEnable ?? this.ifEnable,
        aceptoTerminos: aceptoTerminos ?? this.aceptoTerminos,
        pathTipoDeTienda: pathTipoDeTienda ?? this.pathTipoDeTienda,
        nombreTipoDeTienda: nombreTipoDeTienda ?? this.nombreTipoDeTienda,
      );
}
