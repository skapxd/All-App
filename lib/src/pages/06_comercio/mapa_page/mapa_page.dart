import 'dart:async';

import 'package:allapp/src/data/bloc/mapa/mapa_bloc.dart';
import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/widgets/CustonFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;

class ComercioMapaPage extends StatefulWidget {
  static final String pathName = '/ComercioMapaPage';

  @override
  _ComercioMapaPageState createState() => _ComercioMapaPageState();
}

class _ComercioMapaPageState extends State<ComercioMapaPage>
// with AutomaticKeepAliveClientMixin
{
  // Stream<LP.ServiceStatus> statusStream;
  Stream<bool> locationEventStream;

  @override
  void didChangeDependencies() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    locationEventStream = LP.LocationPermissions()
        .serviceStatus
        .map((s) => s == LP.ServiceStatus.enabled ? true : false);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    // locationEventStream = LP.LocationPermissions()
    //     .serviceStatus
    //     .map((s) => s == LP.ServiceStatus.enabled ? true : false);
    // statusStream = LP.LocationPermissions().serviceStatus;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    // final Stream<LP.ServiceStatus> statusStream =
    //     LP.LocationPermissions().serviceStatus;

    return Scaffold(
      body: Container(
        height: vh,
        width: vw,
        child: Stack(
          children: [
            // StreamBuilder(
            //   stream: statusStream,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.data == LP.ServiceStatus.disabled) {
            //       // showCustomDialog(context);
            //       return Container(
            //         child: Center(
            //           child: Text('Porfavor habilite el GPS para continuar'),
            //         ),
            //       );
            //     } else {
            //       return Container(
            //         child: Center(
            //           child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            //             builder: (context, state) {
            //               if (!state.ifLocationExist)
            //                 return Text('Ubicando...');

            //               final camaraPosition = CameraPosition(
            //                 target: state.ubicacion,
            //               );
            //               // return Container();
            //               return GoogleMap(
            //                 myLocationButtonEnabled: false,
            //                 myLocationEnabled: true,
            //                 zoomControlsEnabled: false,
            //                 initialCameraPosition: camaraPosition,
            //                 onMapCreated: (controller) {
            //                   BlocProvider.of<MapaBloc>(context)
            //                       .initMapComercio(controller);
            //                 },
            //               );
            //             },
            //           ),
            //         ),
            //       );
            //     }
            //   },
            // ),
            Container(
              child: Center(
                child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
                  builder: (context, state) {
                    if (!state.ifLocationExist) return Text('Ubicando...');

                    final camaraPosition = CameraPosition(
                      target: state.ubicacion,
                    );
                    // return Container();
                    return GoogleMap(
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      initialCameraPosition: camaraPosition,
                      onMapCreated: (controller) {
                        BlocProvider.of<MapaBloc>(context)
                            .initMapComercio(controller);
                      },
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: CustonFloatingActionButton(
                onTap: () {
                  final mapaBloc = BlocProvider.of<MapaBloc>(context);
                  final miUbicacionBloc =
                      BlocProvider.of<MiUbicacionBloc>(context);

                  final destino = miUbicacionBloc.state.ubicacion;
                  mapaBloc.moverCamaraComercio(destino);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
