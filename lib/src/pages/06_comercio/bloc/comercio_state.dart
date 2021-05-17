part of 'comercio_bloc.dart';

@immutable
class ComercioState {
  final File icon;
  final bool ifEnable;
  final bool aceptoTerminos;

  ComercioState({
    this.icon,
    this.ifEnable,
    this.aceptoTerminos,
  });

  ComercioState copyWith({File icon, bool ifEnable, bool aceptoTerminos}) =>
      ComercioState(
        icon: icon ?? this.icon,
        ifEnable: ifEnable ?? this.ifEnable,
        aceptoTerminos: aceptoTerminos ?? this.aceptoTerminos,
      );
}
