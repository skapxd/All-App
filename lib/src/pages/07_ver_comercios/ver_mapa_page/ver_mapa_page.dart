// import 'package:allapp/src/models/cache_store_model/_cache_store_model.dart'
//     as Cache;
import 'package:allapp/src/models/cache_store_model/__cache_store_model.dart'
    as Cache;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/bloc/mapa/mapa_bloc.dart';
import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../utils/utils.dart';
import '../../../widgets/CustonFloatingActionButton.dart';

class VerMapaPage extends StatefulWidget {
  static final String pathName = '/VerMapaPage';

  @override
  _VerMapaPageState createState() => _VerMapaPageState();
}

class _VerMapaPageState extends State<VerMapaPage>
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

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final List<Cache.LatLng> position = args['latLng'];

    print('VerMapaPage - position: $position');

    final LatLng latLng = LatLng(
      position[0].lat,
      position[0].lng,
      // 6.02812720125828,
      // -75.43562047183514,
    );

    Map<MarkerId, Marker> markers;

    int i = 0;

    position.forEach((element) {
      //

      if (markers == null) {
        markers = {};
      }

      markers.addAll(
        {
          MarkerId('$i'): Marker(
            markerId: MarkerId('$i'),
            position: LatLng(element.lat, element.lng),
          ),
        },
      );
      i++;
    });

    final camaraPosition = CameraPosition(
      target: latLng,
      zoom: 17,
    );

    return Scaffold(
      backgroundColor: hexaColor('#232323'),
      body: Container(
        height: vh,
        width: vw,
        child: Stack(
          children: [
            Container(
              child: Center(
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: camaraPosition,
                  markers: markers.values.toSet(),
                  onMapCreated: (controller) {
                    BlocProvider.of<MapaBloc>(context)
                        .initMapComercio(controller);
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
                  mapaBloc.moverCamaraComercio(latLng);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
