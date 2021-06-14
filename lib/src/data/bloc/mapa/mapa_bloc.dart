import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../theme/map_style.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _mapHomeController;
  GoogleMapController _mapComercioController;

  void initMapHome(GoogleMapController controller) {
    this._mapHomeController = controller;

    this._mapHomeController.setMapStyle(jsonEncode(mapStyle2));

    add(OnMapaListo());
  }

  void moverCamaraHome(LatLng destino) {
    try {
      final cameraUpdate = CameraUpdate.newLatLng(destino);

      this._mapHomeController?.animateCamera(cameraUpdate);
    } catch (e) {
      print('MapaBloc - moverCamaraHome - error: $e');
    }
  }

  ///////////////////

  void initMapComercio(GoogleMapController controller) {
    this._mapComercioController = controller;

    this._mapComercioController.setMapStyle(jsonEncode(mapStyle2));

    add(OnMapaListo());
  }

  void moverCamaraComercio(LatLng destino) {
    try {
      final cameraUpdate = CameraUpdate.newLatLng(destino);

      this._mapComercioController?.animateCamera(cameraUpdate);
    } catch (e) {
      print('MapaBloc - moverCamaraComercio - error: $e');
    }
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaListo) {
      print('MapaBloc - mapEventToState - mapa listo');
      yield MapaState().copyWith(mapaListo: true);
    }
  }
}
