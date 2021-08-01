import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';

class TitleGrupoProductos extends StatelessWidget {
  final String name;

  TitleGrupoProductos({
    @required this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return ListTile(
      title: Text(
        this.name,
        style: TextStyle(
          color: hexaColor('#DDDDDD'),
        ),
      ),
      onTap: () {
        // DBFirestore().addMyCategori(
        //   phoneIdStore: Pref().phone,
        //   cityPath: miUbicacionBloc.address,
        //   categories: this.name,
        // );
        Navigator.pop(context);
        print('TitleGrupoProductos - this.name: ${this.name}');
      },
    );
  }
}
