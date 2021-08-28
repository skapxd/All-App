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

class AddIfVisibility extends ComercioEvent {
  final bool ifVisibility;

  AddIfVisibility(this.ifVisibility);
}

class AddAceptoTerminos extends ComercioEvent {
  final bool aceptoTerminos;

  AddAceptoTerminos(this.aceptoTerminos);
}

class AddToggleViewStore extends ComercioEvent {
  final bool ifView;

  AddToggleViewStore(this.ifView);
}

class AddNombreTipoDeTienda extends ComercioEvent {
  final String nombreTipoDeTienda;

  AddNombreTipoDeTienda(this.nombreTipoDeTienda);
}

class AddPathTipoDeTienda extends ComercioEvent {
  final String pathTipoDeTienda;

  AddPathTipoDeTienda(this.pathTipoDeTienda);
}

class AddMarkers extends ComercioEvent {
  final LatLng marker;
  final BuildContext context;

  AddMarkers(this.marker, this.context);
}

class AddMapOfMarkers extends ComercioEvent {
  final BuildContext context;
  final Map<MarkerId, Marker> markers;

  AddMapOfMarkers(this.markers, this.context);
}

class ClearMarkers extends ComercioEvent {
  ClearMarkers();
}

class SaveMarkers extends ComercioEvent {
  SaveMarkers();
}

class RemoveOneMarkers extends ComercioEvent {
  final int index;
  RemoveOneMarkers(this.index);
}