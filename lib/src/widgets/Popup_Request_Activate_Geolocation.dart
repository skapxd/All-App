import '../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_permissions/location_permissions.dart' as LP;

class PopupRequestActivateGeolocation extends StatefulWidget {
  @override
  _PopupRequestActivateGeolocationState createState() =>
      _PopupRequestActivateGeolocationState();
}

class _PopupRequestActivateGeolocationState
    extends State<PopupRequestActivateGeolocation> {
  Stream<bool> locationEventStream;

  @override
  void initState() {
    locationEventStream = LP.LocationPermissions()
        .serviceStatus
        .asBroadcastStream()
        .map((s) => s == LP.ServiceStatus.enabled ? true : false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    // View Width
    final double vw = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: locationEventStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.data) {
          return Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            color: rgbColor(0, 0, 0, 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: vw * 0.5,
                  height: vw * 0.5,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Por favor active el geolocalizador',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: hexaColor('#303030')),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // if (_miUbicacionBloc.state.initPosition == null) {
        //   accesoGps(
        //     onGranted: () {
        //       _miUbicacionBloc.initPosition();
        //     },
        //   );
        // }

        return Container();
      },
    );
  }
}
