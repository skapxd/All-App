import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/db/firestore.dart';
import '../../../data/shared/pref.dart';
import '../../../utils/utils.dart';
import '../bloc/comercio_bloc.dart';

class ModalButtomTipoDeTienda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ListItems();
  }
}

class _IconPath {
  final String path;
  final String name;

  _IconPath({
    @required this.path,
    @required this.name,
  });
}

class _ListItems extends StatelessWidget {
  final List<_IconPath> listOfStringIconsPaths = [
    _IconPath(
      path: 'assets/ruburos/supermercado.svg',
      name: 'Supermercado',
    ),
    _IconPath(
      path: 'assets/ruburos/comida rápida.svg',
      name: 'Comida rápida',
    ),
    _IconPath(
      path: 'assets/ruburos/drogueria.svg',
      name: 'Drogueria',
    ),
    _IconPath(
      path: 'assets/ruburos/ferreteria.svg',
      name: 'Ferreteria',
    ),
    _IconPath(
      path: 'assets/ruburos/restaurantes.svg',
      name: 'Restaurantes',
    ),
    _IconPath(
      path: 'assets/ruburos/calzado.svg',
      name: 'Calzado',
    ),
    _IconPath(
      path: 'assets/ruburos/cosmetiscos.svg',
      name: 'Cosmetiscos',
    ),
    _IconPath(
      path: 'assets/ruburos/electrónicos.svg',
      name: 'Electrónicos',
    ),
    _IconPath(
      path: 'assets/ruburos/licor.svg',
      name: 'Licor',
    ),
    _IconPath(
      path: 'assets/ruburos/carniceria.svg',
      name: 'Carniceria',
    ),
    _IconPath(
      path: 'assets/ruburos/minimercado.svg',
      name: 'Minimercado',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;
    final double vw = MediaQuery.of(context).size.width;

    return Container(
      height: vh * 0.8,
      padding: EdgeInsets.only(
        top: vw * 0.07,
        left: vw * 0.07,
        right: vw * 0.07,
      ),
      decoration: BoxDecoration(
        color: hexaColor('#333333'),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(vw * 0.05),
          topRight: Radius.circular(vw * 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Eliga su tipo de comercio',
              style: TextStyle(
                color: hexaColor('#FFFFFF'),
              ),
            ),
          ),
          SizedBox(
            height: vw * 0.01,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: listOfStringIconsPaths.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _Item(
                    iconPath: listOfStringIconsPaths[index].path,
                    name: listOfStringIconsPaths[index].name,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String iconPath;
  final String name;
  final _pref = Pref();

  _Item({
    @required this.iconPath,
    @required this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context).state;

    final comercioBloc = BlocProvider.of<ComercioBloc>(context);

    return ListTile(
      title: Text(
        this.name,
        style: TextStyle(
          color: hexaColor('#DDDDDD'),
        ),
      ),
      leading: Container(
        height: 25,
        width: 25,
        child: SvgPicture.asset(this.iconPath),
      ),
      onTap: () {
        Navigator.pop(context);
        comercioBloc.add(AddNombreTipoDeTienda(this.name));
        comercioBloc.add(AddPathTipoDeTienda(this.iconPath));

        DBFirestore().removeStore(
          categories: _pref.nombreTipoDeTienda,
          phoneIdStore: _pref.phone,
          cityPath: miUbicacion.address,
        );

        _pref.nombreTipoDeTienda = this.name.toLowerCase();
        _pref.pathTipoDeTienda = this.iconPath.toLowerCase();
      },
    );
  }
}
