import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;

import '../../../data/bloc/mapa/mapa_bloc.dart';
import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../utils/utils.dart';
import '../../../widgets/CustomText.dart';
import '../../../widgets/CustonFloatingActionButton.dart';

class ComercioMapaPage extends StatefulWidget {
  static final String pathName = '/ComercioMapaPage';

  @override
  _ComercioMapaPageState createState() => _ComercioMapaPageState();
}

class _ComercioMapaPageState extends State<ComercioMapaPage>
// with AutomaticKeepAliveClientMixin
{
  MiUbicacionBloc miUbicacionBloc;

  @override
  void didChangeDependencies() {
    miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    miUbicacionBloc.iniciarSeguimiento();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    miUbicacionBloc.cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: hexaColor('#232323'),
      body: Container(
        height: vh,
        width: vw,
        child: Stack(
          children: [
            StreamBuilder(
              stream: miUbicacionBloc.statusStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == LP.ServiceStatus.disabled) {
                  // showCustomDialog(context);
                  return Center(
                    child: CustomText(
                      'Porfavor habilite el GPS para continuar',
                      style: CustomText.defaultTextStayle
                          .copyWith(letterSpacing: 0),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
                        builder: (context, state) {
                          if (!state.ifLocationExist)
                            return Text('Ubicando...');

                          final camaraPosition = CameraPosition(
                            target: state.latLng,
                            zoom: 17,
                          );
                          // return Container();
                          return GoogleMap(
                            // indoorViewEnabled: false,
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
            //           target: state.latLng,
            //         );
            //         // return Container();
            //         return GoogleMap(
            //           myLocationButtonEnabled: false,
            //           myLocationEnabled: true,
            //           zoomControlsEnabled: false,
            //           initialCameraPosition: camaraPosition,
            //           onMapCreated: (controller) {
            //             BlocProvider.of<MapaBloc>(context)
            //                 .initMapComercio(controller);
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

                  final destino = miUbicacionBloc.state.latLng;
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
