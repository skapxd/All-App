import 'dart:async';

import '../crear_producto_page/crear_producto_page.dart';
import '../../../../utils/utils.dart';

import '../bloc/create_category_product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class TitleGrupoProductos extends StatefulWidget {
  final String name;
  final String category;
  final int index;

  TitleGrupoProductos({
    @required this.name,
    @required this.index,
    @required this.category,
    Key key,
  }) : super(key: key);

  @override
  _TitleGrupoProductosState createState() => _TitleGrupoProductosState();
}

class _TitleGrupoProductosState extends State<TitleGrupoProductos> {
  final colorBase = hexaColor('#ffffff', opacity: 0);
  final colorActivate = hexaColor('#ffffff', opacity: 0.1);

  bool toggleColorLocal;
  bool listOfSelected;
  CreateCategoryProductBloc categoryProductBloc;

  @override
  void initState() {
    super.initState();

    categoryProductBloc = BlocProvider.of<CreateCategoryProductBloc>(context);

    toggleColorLocal = false;
    listOfSelected = false;

    categoryProductBloc.stream.listen((event) {
      listOfSelected = event.mapToggleColor.containsValue(true);
      if (!listOfSelected) {
        toggleColorLocal = false;
      }
      print('TitleGrupoProductos listOfSelected $listOfSelected');
    });
  }

  Widget build(BuildContext context) {
    //

    return Container(
      color: !this.toggleColorLocal ? colorBase : colorActivate,
      // color: this.color,
      child: ListTile(
        title: Text(
          this.widget.name,
          style: TextStyle(
            color: hexaColor('#DDDDDD'),
          ),
        ),
        onLongPress: () {
          // print(object)
          setState(() {
            this.toggleColorLocal = !this.toggleColorLocal;
            categoryProductBloc
                .add(MapToggleColor({widget.index: this.toggleColorLocal}));
          });
        },
        onTap: () {
          if (listOfSelected) {
            setState(() {
              this.toggleColorLocal = !this.toggleColorLocal;
              categoryProductBloc
                  .add(MapToggleColor({widget.index: this.toggleColorLocal}));
            });
          } else {
            Navigator.pushNamed(
              context,
              CrearProductoPage.pathName,
              arguments: widget.category,
            );
          }
        },
      ),
    );
  }
}
