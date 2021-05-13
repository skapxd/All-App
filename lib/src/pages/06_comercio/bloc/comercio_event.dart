part of 'comercio_bloc.dart';

@immutable
abstract class ComercioEvent {}

class AddComercioIcon extends ComercioEvent {
  final File image;

  AddComercioIcon(this.image);
}

class AddComercioIfEnableEditar extends ComercioEvent {
  final bool ifEnable;

  AddComercioIfEnableEditar(this.ifEnable);
}
