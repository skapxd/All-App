import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/db/firestore.dart';
import '../../../data/shared/pref.dart';
import '../../../utils/utils.dart';
import 'widget/modal_buttom_grupo_productos.dart';
import 'widget/single_categorie.dart';

class GrupoProductosPage extends StatelessWidget {
  static final String pathName = '/CrearProductosPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GRUPO DE PRODUCTOS',
          // textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: hexaColor('#E6D29F'),
            letterSpacing: 5,
          ),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(vw),
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: hexaColor('#303030'),
      ),
      backgroundColor: hexaColor('#303030'),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: rgbColor(0, 0, 0, 0),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          // systemNavigationBarColor: hexaColor('#FFFFFF'),
          systemNavigationBarColor: hexaColor('#303030'),
        ),
        sized: false,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: StreamBuilder(
                stream: DBFirestore().getMyCategori(
                  cityPath: miUbicacionBloc.address,
                  phoneIdStore: Pref().phone,
                ),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  //

                  if (snapshot.data == null) {
                    return Container();
                  }
                  final data = snapshot.data.docs;

                  return ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SingleCategorie(
                        index: index,
                        data: data[index].id,
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              bottom: 14.5,
              right: 14.5,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: rgbColor(0, 0, 0, 0),
                    builder: (BuildContext context) {
                      return ModalButtomGrupoProductos();
                    },
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: vw * 0.15,
                      width: vw * 0.15,
                      decoration: BoxDecoration(
                        color: hexaColor('#FFFFFF'),
                        borderRadius: BorderRadius.circular(vw),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(vw * 0.03),
                        child: SvgPicture.asset(
                          'assets/icons/box.svg',
                        ),
                      ),
                    ),
                    Positioned(
                      left: vw * 0.105,
                      // left: 42,
                      child: Icon(
                        Icons.add,
                        color: hexaColor('#aaaaaa'),
                        // color: hexaColor('#FFDEBD'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
