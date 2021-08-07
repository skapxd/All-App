import 'dart:async';

import 'package:allapp/src/pages/08_tienda/crear_comercio/create_category_product/bloc/create_category_product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';

class TitleGrupoProductos extends StatefulWidget {
  final String name;

  TitleGrupoProductos({
    @required this.name,
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
  bool ifInit = true;
  CreateCategoryProductBloc categoryProductBloc;

  @override
  void initState() {
    super.initState();
    categoryProductBloc = BlocProvider.of<CreateCategoryProductBloc>(context);
    toggleColorLocal = false;
    print('TitleGrupoProductos ${categoryProductBloc.state.toggleColor}');

    // categoryProductBloc.stream.listen((event) {
    //   print('TitleGrupoProductos ${event.toggleColor}');
    //   if (event.toggleColor == false && ifInit == false) {
    //     setState(() {
    //       toggleColorLocal = false;
    //     });
    //   }
    // });
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
            // categoryProductBloc.add(AddItemSelected());
          });
        },
        onTap: () {
          if (categoryProductBloc.state.toggleColor) {
            setState(() {
              this.toggleColorLocal = true;
              this.ifInit = false;
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
