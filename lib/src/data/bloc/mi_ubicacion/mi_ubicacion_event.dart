part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class AddUbicacion extends MiUbicacionEvent {
  final LatLng position;

  AddUbicacion(this.position);
}

class AddAddress extends MiUbicacionEvent {
  final AddressModel address;

  AddAddress(this.address);
}

class AddInitPosition extends MiUbicacionEvent {
  final LatLng initPosition;

  AddInitPosition(this.initPosition);
}

class AddMarkers extends MiUbicacionEvent {
  final LatLng marker;

  AddMarkers(this.marker);
}

class ClearMArkers extends MiUbicacionEvent {
  ClearMArkers();
}
