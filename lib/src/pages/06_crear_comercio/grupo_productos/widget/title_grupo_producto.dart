import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../data/db/firestore.dart';
import '../../../../data/shared/pref.dart';
import '../../../../utils/utils.dart';

class TitleGrupoProductos extends StatelessWidget {
  final String name;

  TitleGrupoProductos({
    @required this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return ListTile(
      title: Text(
        this.name,
        style: TextStyle(
          color: hexaColor('#DDDDDD'),
        ),
      ),
      onTap: () {
        DBFirestore().addMyCategori(
          phoneIdStore: Pref().phone,
          cityPath: miUbicacionBloc.address,
          categories: this.name,
        );
        Navigator.pop(context);
        print('TitleGrupoProductos - this.name: ${this.name}');
      },
    );
  }
}
