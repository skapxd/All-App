import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../data/db/firestore.dart';
import '../../../../data/shared/pref.dart';
import '../../../../utils/utils.dart';
import '../../crear-producto-page/crear_producto_page.dart';

class SingleCategorie extends StatelessWidget {
  final int index;
  final String data;

  final random = Random();
  SingleCategorie({
    @required this.index,
    @required this.data,
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
          Navigator.pushNamed(
            context,
            CrearProductoPage.pathName,
            arguments: data,
          );
          print(data);
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
                      'Confirme la eliminación del grupo',
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

                          Navigator.pop(context);

                          DBFirestore().deleteMyCategori(
                            phoneIdStore: Pref().phone,
                            cityPath: miUbicacionBloc.address,
                            categories: data,
                          );
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
              data[0],
              style: TextStyle(
                fontSize: 24,
                color: hexaColor('#DDDDDD'),
              ),
            ),
          ),
          // child: SvgPicture.asset(
          //   'assets/icons/box.svg',
          //   color: hexaColor('#FFDEBD'),
          // ),
        ),
        title: Text(
          data,
          style: TextStyle(
            color: hexaColor('#DDDDDD'),
          ),
        ),
      ),
    );
  }
}
