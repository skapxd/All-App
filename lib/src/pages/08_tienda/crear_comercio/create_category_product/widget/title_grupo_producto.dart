import 'dart:async';

import 'package:allapp/src/pages/08_tienda/crear_comercio/create_category_product/bloc/create_category_product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';

class TitleGrupoProductos extends StatefulWidget {
  final String name;
  final int index;

  TitleGrupoProductos({
    @required this.name,
    @required this.index,
    Key key,
  }) : super(key: key);

  @override
  _TitleGrupoProductosState createState() => _TitleGrupoProductosState();
}

class _TitleGrupoProductosState extends State<TitleGrupoProductos> {
  final colorBase = hexaColor('#ffffff', opacity: 0);
  final colorActivate = hexaColor('#ffffff', opacity: 0.1);
  final StreamController<bool> _streamController = StreamController.broadcast();

  Stream<bool> get changeColor => _streamController.stream;

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

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
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
          }
          // DBFirestore().addMyCategori(
          //   phoneIdStore: Pref().phone,
          //   cityPath: miUbicacionBloc.address,
          //   categories: this.name,
          // );
          // if (state.toggleColor) {}
          // Navigator.pop(context);
          // print('TitleGrupoProductos - this.name: ${this.name}');
        },
      ),
    );
    // return BlocBuilder<CreateCategoryProductBloc, CreateCategoryProductState>(
    //   builder: (context, state) {
    //     // print('TitleGrupoProductos local $toggleColorLocal');
    //     print('TitleGrupoProductos state ${state.toggleColor}');
    //     return Container(
    //       color: !categoryProductBloc.state.toggleColor
    //           ? colorBase
    //           : colorActivate,
    //       // color: this.color,
    //       child: ListTile(
    //         title: Text(
    //           this.widget.name,
    //           style: TextStyle(
    //             color: hexaColor('#DDDDDD'),
    //           ),
    //         ),
    //         onLongPress: () {
    //           // print(object)
    //           categoryProductBloc.add(AddItemSelected());
    //           setState(() {
    //             // this.toggleColorLocal = !this.toggleColorLocal;
    //           });
    //         },
    //         onTap: () {
    //           if (categoryProductBloc.state.toggleColor) {
    //             setState(() {
    //               // this.toggleColorLocal = !this.toggleColorLocal;
    //             });
    //           }
    //           // DBFirestore().addMyCategori(
    //           //   phoneIdStore: Pref().phone,
    //           //   cityPath: miUbicacionBloc.address,
    //           //   categories: this.name,
    //           // );
    //           // if (state.toggleColor) {}
    //           // Navigator.pop(context);
    //           // print('TitleGrupoProductos - this.name: ${this.name}');
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}
