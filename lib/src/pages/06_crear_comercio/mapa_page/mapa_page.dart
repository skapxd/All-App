import 'dart:ui';

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
                            onTap: (position) {
                              print(position);
                              miUbicacionBloc.add(AddMarkers(position));
                            },
                            // indoorViewEnabled: false,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            markers: state.markers.values.toSet(),
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
            _MarcadorManual(),
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

                  miUbicacionBloc.state.markers.forEach((key, value) {
                    print(value.position.toString());
                  });
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

class _MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    return Stack(
      children: [
        Positioned(
          top: 0,
          // left: 30,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 100,
                width: vw,
                decoration: BoxDecoration(
                  color: rgbColor(0, 0, 0, 0.3),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: hexaColor('#d5d5d5'),
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Text(
                      'Seleccione la ubicación \nde su comercio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: hexaColor('#d5d5d5'),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                      flex: 2,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: hexaColor('#d5d5d5'),
                      ),
                      onPressed: () {
                        miUbicacionBloc.add(ClearMArkers());
                      },
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Positioned(
        //   bottom: 10,
        //   child: Container(
        //     width: vw * 0.3,
        //     height: 50,
        //     color: hexaColor('#FFFFFF'),
        //   ),
        // )
        // Container(
        //   height: 100,
        //   width: 100,
        //   color: Colors.pink,
        // ),
      ],
    );
  }
}
