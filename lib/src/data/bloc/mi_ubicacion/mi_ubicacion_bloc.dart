import 'dart:async';
import 'dart:convert';

import 'package:allapp/src/data/shared/pref.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;
import 'package:meta/meta.dart';

import '../../../models/ConverGeoLocationToAdress.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

  StreamSubscription<Position> _positionSuscriptio;

  final Stream<LP.ServiceStatus> statusStream =
      LP.LocationPermissions().serviceStatus.asBroadcastStream();

  final gpsStatus = LP.ServiceStatus;

  final _pref = Pref();

  Future<void> initPosition() async {
    //

    final permissionGpsEnable = await Geolocator.isLocationServiceEnabled();

    if (!permissionGpsEnable) {
      // Geolocator.requestPermission();
      return;
    }

    if (state.initPosition == null) {
      //

      final initPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latLng = LatLng(initPosition.latitude, initPosition.longitude);

      print('${latLng.latitude}, ${latLng.longitude}');

      _pref.latLanDeTienda = '${latLng.latitude}, ${latLng.longitude}';

      add(AddInitPosition(latLng));

      final googleAPI = Dio(
        BaseOptions(baseUrl: 'https://maps.googleapis.com/maps/api/geocode'),
      );

      try {
        final respTemp = await googleAPI.get('/json', queryParameters: {
          'key': 'AIzaSyAvrhAPN1yEHRSB_EFLVsfFUJyXe8gMEAs',
          'latlng': '${latLng.latitude},${latLng.longitude}',
          // 'latlng': '5.895947, -75.378383'
        });

        final resp = jsonEncode(respTemp.data);

        final convertGeoLocationToAddress =
            convertGeoLocationToAddressFromJson(resp);

        final addressTemp =
            convertGeoLocationToAddress.results[0].formattedAddress.split(',');

        addressTemp.removeAt(0);

        List<String> addressList = addressTemp.reversed.map((e) {
          //

          final f = e.replaceFirst(' ', '');

          final g = f.replaceAll(' ', '_').toLowerCase();

          return g;
        }).toList();

        // final addressToString =
        //     addressList.join('/').replaceAll(' ', '_').toLowerCase();

        print('$addressList');

        final address = Address(
          city: addressList[2],
          country: addressList[0],
          department: addressList[1],
        );

        add(AddAddress(address));
      } catch (e) {
        print(e);
        return;
      }
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

  @deprecated
  Future<LatLng> getPosition() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final latLng = LatLng(position.latitude, position.longitude);

    return latLng;
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

      yield state.copyWith(initPosition: event.initPosition);
    }
  }
}
