part of 'comercio_bloc.dart';

@immutable
abstract class ComercioState {}

class ComercioInitial extends ComercioState {}

class ComercioIcon extends ComercioState {
  final File icon;

  ComercioIcon({this.icon});
}

class ComercioIfEditar extends ComercioState {
  final bool ifEnable;

  ComercioIfEditar({this.ifEnable});
}
