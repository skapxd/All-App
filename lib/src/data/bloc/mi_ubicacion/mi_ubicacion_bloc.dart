import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

  StreamSubscription<Position> _positionSuscriptio;

  void iniciarSeguimiento() {
    this._positionSuscriptio = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      // print(position);
      final newPosition = new LatLng(position.latitude, position.longitude);
      add(AddUbicacion(newPosition));
    });
  }

  void cancelarSeguimiento() {
    this._positionSuscriptio?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {
    if (event is AddUbicacion) {
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.position,
      );
    }
  }
}
