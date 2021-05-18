import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;
import 'package:permission_handler/permission_handler.dart';

import '../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../models/ConverGeoLocationToAdress.dart';
import '../utils/utils.dart';
import 'CustomText.dart';

class GetGeoPosition extends StatefulWidget {
  final Widget loadingChildStatusGPS;
  final Widget loadingChildGeoLocation;
  final Widget Function() successChild;
  final void Function() onResume;

  const GetGeoPosition({
    Key key,
    this.onResume,
    this.successChild,
    this.loadingChildStatusGPS,
    this.loadingChildGeoLocation,
  }) : super(key: key);

  @override
  _GetGeoPositionState createState() => _GetGeoPositionState();
}

class _GetGeoPositionState extends State<GetGeoPosition>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('=====================> $state');

    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        // BlocProvider.of<HomeBloc>(context).add(AddPageIndex(1));
        if (widget.onResume != null) {
          widget.onResume();
        }
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    LP.LocationPermissions().serviceStatus.listen((event) {
      print('event  ======> $event');
    });

    accesoGps(
      onGranted: () {
        BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = BlocProvider.of<MiUbicacionBloc>(context).state.address;

    return StreamBuilder(
      stream: LP.LocationPermissions().serviceStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == LP.ServiceStatus.disabled) {
          return Center(
            child: CustomText(
              'Porfavor habilite el GPS para continuar',
              style: CustomText.defaultTextStayle.copyWith(letterSpacing: 0),
            ),
          );
        } else {
          if (address != null) {
            return widget.successChild();
          } else {
            return FutureBuilder(
              future: BlocProvider.of<MiUbicacionBloc>(context).getPosition(),
              builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
                final data = snapshot.data;

                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return FutureBuilder(
                      future: converGeoLocationToAddress(
                        lat: '${data.latitude}',
                        lng: '${data.longitude}',
                      ),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<ConvertGeoLocationToAddress> snapshot,
                      ) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            BlocProvider.of<MiUbicacionBloc>(context).add(
                                AddAddress(
                                    snapshot.data.results[0].formattedAddress));
                            return widget.successChild();
                            break;

                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                          default:
                            return widget.loadingChildGeoLocation ??
                                Container();
                            break;
                        }
                      },
                    );

                    break;

                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                  default:
                    return widget.loadingChildGeoLocation ?? Container();
                    break;
                }
              },
            );
          }
        }
      },
    );

    // return BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
    //   builder: (context, state) {
    //     if (state.address != null) {
    //       return widget.successChild();
    //     } else {
    //     }
    //   },
    // );
  }

  Future<ConvertGeoLocationToAddress> converGeoLocationToAddress({
    String lat,
    String lng,
  }) async {
    // print(lat);
    // print(lng);
    final googleAPI = Dio(
      BaseOptions(baseUrl: 'https://maps.googleapis.com/maps/api/geocode'),
    );

    try {
      final respTemp = await googleAPI.get('/json', queryParameters: {
        'key': 'AIzaSyAvrhAPN1yEHRSB_EFLVsfFUJyXe8gMEAs',
        // 'latlng': '$lat,$lng'
        'latlng': '6.024797, -75.436158'
      });

      final resp = jsonEncode(respTemp.data);

      // print('resp =====> $resp');

      return convertGeoLocationToAddressFromJson(resp);
    } catch (e) {
      print(e);
      return ConvertGeoLocationToAddress();
    }
  }
}
