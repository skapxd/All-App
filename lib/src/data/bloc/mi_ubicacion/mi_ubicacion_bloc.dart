import 'dart:async';
import 'dart:convert';

import 'package:allapp/src/data/services/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;
import 'package:meta/meta.dart';

import '../../../models/ConverGeoLocationToAdress.dart';
import '../../../models/address_model.dart';
import '../../shared/pref.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState(markers: Map()));

  StreamSubscription<Position> _positionSuscriptio;

  final Stream<LP.ServiceStatus> statusStream =
      LP.LocationPermissions().serviceStatus.asBroadcastStream();

  final gpsStatus = LP.ServiceStatus;

  final _pref = Pref();

  Future initPosition() async {
    //
    print('MiUbicacionBloc - initPosition - start');

    // final permissionGpsEnable = await Geolocator.isLocationServiceEnabled();

    // if (!permissionGpsEnable) {
    //   locationPermission = await Geolocator.requestPermission();
    // }

    if (state.initPosition == null) {
      // if ((locationPermission == LocationPermission.always ||
      //         locationPermission == LocationPermission.whileInUse) &&
      //     state.initPosition == null) {
      //
      Position initPosition;
      try {
        initPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final latLng = LatLng(initPosition.latitude, initPosition.longitude);

        add(AddInitPosition(latLng));
        print(
            'MiUbicacionBloc - initPosition - lat:${latLng.latitude} lng:${latLng.longitude}');

        final Future<void> Function() getAddressModel = () async {
          final addressModel = await UtilsServices().getAddressModel(
            lat: '${latLng.latitude}',
            lng: '${latLng.longitude}',
          );

          add(AddAddress(addressModel));
        };

        getAddressModel();
      } catch (e) {
        print('Error to get current position');
      }

      return true;
    }
  }

  void iniciarSeguimiento() {
    this._positionSuscriptio = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      final newPosition = new LatLng(position.latitude, position.longitude);
      add(AddUbicacion(newPosition));
    });
  }

  void cancelarSeguimiento() {
    this._positionSuscriptio?.cancel();
  }

  // @deprecated
  // Future<LatLng> getPosition() async {
  //   final position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   final latLng = LatLng(position.latitude, position.longitude);

  //   return latLng;
  // }

  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {
    if (event is AddUbicacion) {
      //

      yield state.copyWith(
        existeUbicacion: true,
        latLng: event.position,
      );
    } else if (event is AddAddress) {
      //

      yield state.copyWith(address: event.address);
    } else if (event is AddInitPosition) {
      //

      yield state.copyWith(initPosition: event.initPosition);
    }
    //  else if (event is AddMarkers) {
    //   //

    //   final markerId = MarkerId(
    //     this.state.markers.length.toString(),
    //   );

    //   final marker = Marker(markerId: markerId, position: event.marker);

    //   final markers = Map<MarkerId, Marker>.from(this.state.markers);

    //   markers[markerId] = marker;

    //   print('MiUbicacionBloc - markers: ${markers}');

    //   yield state.copyWith(markers: markers);
    // }
    else if (event is ClearMArkers) {
      //

      final markers = Map<MarkerId, Marker>.from(this.state.markers);

      markers.clear();

      yield state.copyWith(markers: markers);
    }
  }
}
