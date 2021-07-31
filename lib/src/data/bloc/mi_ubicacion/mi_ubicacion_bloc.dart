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
  MiUbicacionBloc()
      : super(
          MiUbicacionState(markers: Map()),
        );

  StreamSubscription<Position> _positionSuscriptio;

  final Stream<LP.ServiceStatus> statusStream =
      LP.LocationPermissions().serviceStatus.asBroadcastStream();

  final gpsStatus = LP.ServiceStatus;

  final _pref = Pref();

  Future initPosition({
    Function(LatLng latLng) onSuccess,
    Function(dynamic latLng) onError,
  }) async {
    //
    print('MiUbicacionBloc - initPosition - start');

    if (state.initPosition == null) {
      Position initPosition;
      try {
        // Get Current Position of Sensors
        final Future<LatLng> Function() getPositionOfSensors = () async {
          initPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          final latLngTemp =
              LatLng(initPosition.latitude, initPosition.longitude);

          add(AddInitPosition(latLngTemp));
          if (onSuccess != null) {
            onSuccess(latLngTemp);
          }
          return latLngTemp;
        };

        // Set Current Position  to Bloc Provider
        final latLng = await getPositionOfSensors();

        print(
            'MiUbicacionBloc - initPosition - lat:${latLng.latitude} lng:${latLng.longitude}');

        // Get Address Model of Service
        final Future<void> Function() getAddressModel = () async {
          UtilsServices().getAddressModel(
            lat: '${latLng.latitude}',
            lng: '${latLng.longitude}',
            onSuccess: (addressModel) {
              add(AddAddress(addressModel));
              print('MiUbicacionBloc: ${state.existeUbicacion}');
            },
            onError: (message) {
              print('MiUbicacionBloc - getAddressModel - $message');
            },
          );
        };
        // Set Address Model To Bloc Provider
        await getAddressModel();
      } catch (e) {
        print('MiUbicacionBloc - Error to get current position');
        if (onError != null) {
          onError(e);
        }
      }
    } else {
      if (onSuccess != null) {
        onSuccess(state.initPosition);
      }
    }
  }

  void cancelarSeguimiento() {
    this._positionSuscriptio?.cancel();
  }

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

      yield state.copyWith(
        initPosition: event.initPosition,
        existeUbicacion: true,
      );
    }
  }
}
