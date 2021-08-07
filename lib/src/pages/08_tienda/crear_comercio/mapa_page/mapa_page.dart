import 'dart:ui';

// import 'package:allapp/src/data/services/stores/stores_service.dart';
// import 'package:allapp/src/data/shared/store_pref/store_pref.dart';
import 'package:allapp/src/pages/08_tienda/crear_comercio/bloc/comercio_bloc.dart';

import '../../../../data/bloc/mapa/mapa_bloc.dart';
import '../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../models/store_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/CustomText.dart';
import '../../../../widgets/CustonFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart' as LP;

class ComercioMapaPage extends StatefulWidget {
  static final String pathName = '/ComercioMapaPage';

  @override
  _ComercioMapaPageState createState() => _ComercioMapaPageState();
}

class _ComercioMapaPageState extends State<ComercioMapaPage> {
  Stream<bool> locationEventStream;

  MiUbicacionBloc miUbicacionBloc;
  ComercioBloc comercioBloc;

  @override
  void initState() {
    super.initState();
    miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    comercioBloc = BlocProvider.of<ComercioBloc>(context);
    locationEventStream = LP.LocationPermissions()
        .serviceStatus
        .asBroadcastStream()
        .map((s) => s == LP.ServiceStatus.enabled ? true : false);
  }

  @override
  void dispose() {
    comercioBloc.add(ClearMarkers());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final List<LatLngStore> position = args['latLng'];

    print('VerMapaPage - position: ${position.toString()}');

    Map<MarkerId, Marker> markers = comercioBloc.state.markers;

    initMarkers(context, position, markers);

    // final camaraPosition = CameraPosition(
    //   target: latLng,
    //   zoom: 17,
    // );

    return Scaffold(
      backgroundColor: hexaColor('#232323'),
      body: Container(
        height: vh,
        width: vw,
        child: Stack(
          children: [
            StreamBuilder(
              initialData: false,
              stream: locationEventStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.data) {
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
                    child: BlocBuilder<ComercioBloc, ComercioState>(
                      builder: (context, state) {
                        print(
                            'ComercioMapaPage: ${miUbicacionBloc.state.existeUbicacion}');
                        if (!miUbicacionBloc.state.existeUbicacion)
                          return Text('Ubicando...');

                        print(
                            'ComercioMapaPage: ${miUbicacionBloc.state.initPosition}');

                        final camaraPosition = CameraPosition(
                          target: miUbicacionBloc.state.initPosition,
                          zoom: 17,
                        );
                        return GoogleMap(
                          onTap: (position) {
                            print(position);
                            comercioBloc.add(AddMarkers(position, context));
                          },
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          markers: state.markers.values.toSet(),
                          initialCameraPosition: camaraPosition,
                          onMapCreated: (controller) {
                            BlocProvider.of<MapaBloc>(context)
                                .initMapComercio(controller);
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
            _MarcadorManual(),
            Positioned(
              bottom: 20,
              left: 100,
              right: 100,
              child: _SaveLocationButom(
                onTap: () {
                  comercioBloc.add(SaveMarkers());
                },
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

                  final destino = miUbicacionBloc.state.initPosition;
                  mapaBloc.moverCamaraComercio(destino);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initMarkers(
    BuildContext context,
    List<LatLngStore> position,
    // MarkerId markerId,
    Map<MarkerId, Marker> markers,
  ) {
    int i = 0;

    position.forEach((element) {
      // if

      if (markers == null) {
        markers = {};
      }

      final markerId = MarkerId('$i');

      markers.addAll(
        {
          MarkerId('$i'): Marker(
            markerId: markerId,
            position: LatLng(element.lat, element.lng),
            onTap: () {
              print('ComercioBloc - marker: delete $markerId');
              comercioBloc.showMarkerDialog(context, markerId);
            },
          ),
        },
      );
      comercioBloc.add(AddMapOfMarkers(markers, context));
      i++;
    });
  }
}

class _MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final comercioBloc = BlocProvider.of<ComercioBloc>(context);

    return Stack(
      children: [
        Positioned(
          top: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                padding: EdgeInsets.only(top: 20),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Text(
                      'Seleccione la ubicación \nde sus comercios',
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
                        comercioBloc.add(ClearMarkers());
                        // StorePrefPosition().deleteLatLngList();
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
      ],
    );
  }
}

class _SaveLocationButom extends StatelessWidget {
  final Function() onTap;

  const _SaveLocationButom({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text('GUARDAR'),
      ),
    );
  }
}
