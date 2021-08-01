import 'dart:math';

import '../../../../../utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

import 'modal_bottom_tienda.dart';

class ItemProduct extends StatelessWidget {
  final int index;
  final String category;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  final random = Random();
  ItemProduct({
    @required this.index,
    @required this.data,
    @required this.category,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    return Container(
      // height: 80,
      // color: Colors.red,
      margin: EdgeInsets.only(
        top: index == 0 ? 70 : 20,
      ),
      child: ListTile(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: rgbColor(0, 0, 0, 0),
            barrierColor: rgbColor(0, 0, 0, 0),
            builder: (BuildContext context) {
              return ModalButtomProducto(
                textButtom: 'MODIFICAR',
                idProduct: this.data.id,
                categori: category,
                cantidad: this.data.data()['cantidad'],
                disponibilidad: this.data.data()['disponibilidad'],
                nombre: this.data.data()['nombre'],
                precio: this.data.data()['precio'],
                urlImage: this.data.data()['urlImageProducto'],
              );
            },
          );
        },
        trailing: Container(
          child: IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: hexaColor('#DDDDDD'),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: hexaColor('#303030'),
                    title: Text(
                      'Confirme la eliminación del producto',
                      style: TextStyle(
                        color: hexaColor('#DDDDDD'),
                      ),
                    ),
                    actions: [
                      OutlinedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            hexaColor('#DDDDDD', opacity: 0.1),
                          ),
                        ),
                        onPressed: () {
                          //

                          Navigator.pop(context);
                        },
                        child: Text(
                          'Mejor no',
                          style: TextStyle(
                            color: hexaColor('#DDDDDD'),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            hexaColor('#DDDDDD'),
                          ),
                        ),
                        onPressed: () {
                          //

                          // DBFirestore().deleteProducInMyCategori(
                          //   productName: data.id,
                          //   categories: category,
                          //   phoneIdStore: Pref().phone,
                          //   cityPath: miUbicacionBloc.address,
                          // );

                          Navigator.pop(context);
                        },
                        child: Text(
                          'Borrar',
                          style: TextStyle(
                            color: hexaColor('#303030'),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        leading: Container(
          // height: 80,
          width: 60,
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: rgbColor(r, g, b, 1),
            color: this.data.data()['urlImageProducto'] != null
                ? rgbColor(0, 0, 0, 0)
                : hexaColor('#BEA07D'),
          ),
          child: this.data.data()['urlImageProducto'] == null
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: SvgPicture.asset('assets/icons/box.svg'),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: vw * 0.25,
                        width: vw * 0.25,
                        color: Colors.pink,
                      );
                    },
                    placeholder: kTransparentImage,
                    image: this.data.data()['urlImageProducto'],
                    // height: vw * 0.25,
                    // width: vw * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        title: Text(
          data.data()['nombre'] ?? '',
          style: TextStyle(
            color: hexaColor('#DDDDDD'),
          ),
        ),
      ),
    );
  }
}
