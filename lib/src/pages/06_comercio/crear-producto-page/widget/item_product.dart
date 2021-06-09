import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../data/db/firestore.dart';
import '../../../../data/shared/pref.dart';
import '../../../../utils/utils.dart';
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
    //

    final r = random.nextInt(150) + 50;
    final g = random.nextInt(150) + 50;
    final b = random.nextInt(150) + 50;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return Container(
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
                idProduct: data.id,
                categori: category,
                cantidad: data.data()['cantidad'],
                disponibilidad: data.data()['disponibilidad'],
                nombre: data.data()['nombre'],
                precio: data.data()['precio'],
                urlImage: data.data()['urlImageProducto'],
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

                          print(data);

                          DBFirestore().deleteProducInMyCategori(
                            productName: data.id,
                            categories: category,
                            phoneIdStore: Pref().phone,
                            cityPath: miUbicacionBloc.address,
                          );

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
          height: 50,
          width: 50,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: rgbColor(r, g, b, 1),
          ),
          child: Center(
            child: Text(
              data.data()['nombre'] == null ? '' : data.data()['nombre'][0],
              style: TextStyle(
                fontSize: 24,
                color: hexaColor('#DDDDDD'),
              ),
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
