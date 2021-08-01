import '../../widgets/Popup_Request_Activate_Geolocation.dart';

import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../02_03_Phone/02_Enter_Phone.dart';
import '../../utils/utils.dart';
import '../../widgets/BackgroundGradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PermisosPage extends StatelessWidget {
  static final String pathName = '/PermisosPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomBackgroundGradient(
        child: Stack(
          children: [
            RequestPermisionPage(vw: vw),
            PopupRequestActivateGeolocation()
          ],
        ),
      ),
    );
  }
}

// class PopupRequestActivateGeolocation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // View Width
//     final double vw = MediaQuery.of(context).size.width;
//     // View Height
//     final double vh = MediaQuery.of(context).size.height;

//     final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

//     return StreamBuilder(
//       stream: miUbicacionBloc.statusStream,
//       builder:
//           (BuildContext context, AsyncSnapshot<LP.ServiceStatus> snapshot) {
//         print(snapshot.data);
//         if (snapshot.data == LP.ServiceStatus.disabled ||
//             snapshot.data == null) {
//           return Container(
//             alignment: Alignment.center,
//             height: double.infinity,
//             width: double.infinity,
//             color: rgbColor(0, 0, 0, 0.4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: vw * 0.5,
//                   height: vw * 0.5,
//                   color: Colors.white,
//                   child: Center(
//                     child: Text(
//                       'Por favor active el geolocalizador',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: hexaColor('#303030')),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         return Container();
//       },
//     );
//   }
// }

class RequestPermisionPage extends StatelessWidget {
  const RequestPermisionPage({
    Key key,
    @required this.vw,
  }) : super(key: key);

  final double vw;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          right: vw * 0.04,
          left: vw * 0.04,
          top: vw * 0.25,
          bottom: vw * 0.2,
        ),
        decoration: BoxDecoration(
          color: hexaColor('#d6d6d6'),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: vw * 0.1,
            ),
            SvgPicture.asset(
              'assets/brand/logo.svg',
              height: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'solicita acceso a',
              style: TextStyle(
                fontSize: 22,
                color: hexaColor('#4f4f4f'),
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: vw * 0.05,
            ),
            _Permisos(
              iconPath: 'assets/icons/lat-lan-2.svg',
              subTitle:
                  'All App usara su ubicación\ngps para mostrarle las\ntiendas mas cercanas',
              title: 'Ubicación',
            ),
            SizedBox(
              height: 15,
            ),
            _Permisos(
              iconPath: 'assets/icons/carpeta.svg',
              title: 'Almacenamiento',
              subTitle:
                  'Al momento de crear una \ntienda y subir sus productos \nAll App necesitara acceso \npara abrir sus archivos\nmultimedia ',
            ),
            SizedBox(
              height: 15,
            ),
            _Permisos(
              title: 'Teléfono',
              iconPath: 'assets/icons/telefono.svg',
              subTitle:
                  'All App le enviara un msj \npara verificar su número \ntelefonico',
            ),
            SizedBox(
              height: vw * 0.05,
            ),
            MaterialButton(
              onPressed: () {
                accesoGps(
                  onGranted: () {
                    final _miUbicacionBloc =
                        BlocProvider.of<MiUbicacionBloc>(context);

                    _miUbicacionBloc.initPosition();

                    Navigator.pushNamed(context, EnterPhone.pathName);
                  },
                );
              },
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'PERMITIR ACCESO',
                style: TextStyle(
                  letterSpacing: 3,
                  color: hexaColor('#FFFFFF'),
                ),
              ),
              color: hexaColor('#16d66c'),
            ),
            SizedBox(
              height: vw * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

class _Permisos extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;

  const _Permisos({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: vw * 0.08),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              this.iconPath,
              // height: 40,
              // width: 40,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                this.subTitle,
                style: TextStyle(
                  fontSize: 12,
                  color: hexaColor('#8c8c8c'),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                // color: Colors.red,
                width: 150,
                // color: rgbColor(255, 0, 0, 1),
                color: hexaColor('#aaaaaa'),
              )
            ],
          )
        ],
      ),
    );
  }
}
