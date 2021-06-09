import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/db/firestore.dart';
import '../../../data/shared/pref.dart';
import '../../../utils/utils.dart';
import 'widget/item_product.dart';
import 'widget/modal_bottom_tienda.dart';

class CrearProductoPage extends StatelessWidget {
  //

  static final pathName = 'CrearProductoPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final categorieName = ModalRoute.of(context).settings.arguments;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0x00000000),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categorieName,
            // 'PRODUCTOS',
            textAlign: TextAlign.center,
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
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: StreamBuilder(
                stream: DBFirestore().getProducInMyCategori(
                  cityPath: miUbicacionBloc.address,
                  phoneIdStore: Pref().phone,
                  categories: categorieName,
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
                      return ItemProduct(
                        category: categorieName,
                        index: index,
                        data: data[index],
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
                    barrierColor: rgbColor(0, 0, 0, 0),
                    builder: (BuildContext context) {
                      return ModalButtomProducto(
                        textButtom: 'AÑADIR PRODUCTO',
                        categori: categorieName,
                      );
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
