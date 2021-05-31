part of 'comercio_bloc.dart';

@immutable
class ComercioState {
  final File icon;
  final bool ifView;
  final bool ifEnable;
  final bool aceptoTerminos;

  ComercioState({
    this.icon,
    this.ifView,
    this.ifEnable,
    this.aceptoTerminos,
  });

  ComercioState copyWith({
    File icon,
    bool ifView,
    bool ifEnable,
    bool aceptoTerminos,
  }) =>
      ComercioState(
        icon: icon ?? this.icon,
        ifView: ifView ?? this.ifView,
        ifEnable: ifEnable ?? this.ifEnable,
        aceptoTerminos: aceptoTerminos ?? this.aceptoTerminos,
      );
}
