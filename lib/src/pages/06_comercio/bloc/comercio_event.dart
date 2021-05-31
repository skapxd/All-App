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

class AddAceptoTerminos extends ComercioEvent {
  final bool aceptoTerminos;

  AddAceptoTerminos(this.aceptoTerminos);
}

class AddToggleViewStore extends ComercioEvent {
  final bool ifView;

  AddToggleViewStore(this.ifView);
}
