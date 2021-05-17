import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/bloc/mapa/mapa_bloc.dart';
import 'package:allapp/src/widgets/CustonFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();

    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final Stream<LP.ServiceStatus> statusStream =
        LP.LocationPermissions().serviceStatus;

    return Container(
      height: vh,
      width: vw,
      child: Stack(
        children: [
          StreamBuilder(
            stream: statusStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == LP.ServiceStatus.disabled) {
                return Container(
                  child: Center(
                    child: Text('Porfavor habilite el GPS para continuar'),
                  ),
                );
              } else {
                return Container(
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
                                .initMapHome(controller);
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),

          // Container(
          //   child: Center(
          //     child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          //       builder: (context, state) {
          //         if (!state.ifLocationExist) return Text('Ubicando...');

          //         final camaraPosition = CameraPosition(
          //           target: state.ubicacion,
          //         );
          //         // return Container();
          //         return GoogleMap(
          //           myLocationButtonEnabled: false,
          //           myLocationEnabled: true,
          //           zoomControlsEnabled: false,
          //           initialCameraPosition: camaraPosition,
          //           onMapCreated: (controller) {
          //             BlocProvider.of<MapaBloc>(context)
          //                 .initMapHome(controller);
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),

          Positioned(
            bottom: 10,
            right: 10,
            child: CustonFloatingActionButton(
              onTap: () {
                final mapaBloc = BlocProvider.of<MapaBloc>(context);
                final miUbicacionBloc =
                    BlocProvider.of<MiUbicacionBloc>(context);

                final destino = miUbicacionBloc.state.ubicacion;
                mapaBloc.moverCamaraHome(destino);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// class _Mapa extends StatefulWidget {
//   @override
//   __MapaState createState() => __MapaState();
// }

// class __MapaState extends State<_Mapa> with AutomaticKeepAliveClientMixin {
//   final Stream<LP.ServiceStatus> statusStream =
//       LP.LocationPermissions().serviceStatus;

//   @override
//   void initState() {
//     BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();

//     // super.build(context);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: statusStream,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.data == LP.ServiceStatus.disabled) {
//           // showCustomDialog(context);
//           return Container(
//             child: Center(
//               child: Text('Porfavor habilite el GPS para continuar'),
//             ),
//           );
//         } else {
//           return Container(
//             child: Center(
//               child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
//                 builder: (context, state) {
//                   if (!state.ifLocationExist) return Text('Ubicando...');

//                   final camaraPosition = CameraPosition(
//                     target: state.ubicacion,
//                   );
//                   // return Container();
//                   return GoogleMap(
//                     myLocationButtonEnabled: false,
//                     myLocationEnabled: true,
//                     zoomControlsEnabled: false,
//                     initialCameraPosition: camaraPosition,
//                     onMapCreated: (controller) {
//                       BlocProvider.of<MapaBloc>(context)
//                           .initMapHome(controller);
//                     },
//                   );
//                 },
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
