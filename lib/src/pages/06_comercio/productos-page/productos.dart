import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/db/firestore.dart';
import 'package:allapp/src/data/shared/pref.dart';
import 'package:allapp/src/pages/06_comercio/crear-producto-page/crear-producto-page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:math';

import '../../../utils/utils.dart';

class ProductosPage extends StatelessWidget {
  static final String pathName = '/CrearProductosPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GRUPO DE PRODUCTOS',
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: rgbColor(0, 0, 0, 0),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          // systemNavigationBarColor: hexaColor('#FFFFFF'),
          systemNavigationBarColor: hexaColor('#303030'),
        ),
        sized: false,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: StreamBuilder(
                stream: DBFirestore().getMyCategori(
                  cityPath: miUbicacionBloc.address,
                  phoneIdStore: Pref().phone,
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
                      return _SingleCategorie(
                        index: index,
                        data: data[index].id,
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
                    builder: (BuildContext context) {
                      return _ModalButtomTipoDeTienda();
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

class _SingleCategorie extends StatelessWidget {
  final int index;
  final String data;

  final random = Random();
  _SingleCategorie({
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
                      'Seguro de eliminar este grupo?¿',
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

class _ModalButtomTipoDeTienda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ListItems();
  }
}

class _ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;
    final double vw = MediaQuery.of(context).size.width;
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;

    return FutureBuilder(
      future: DBFirestore().getCategory(categories: 'supermercado'),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //

        final data = snapshot.data;

        if (data == null) {
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
          );
        }

        // print(data);

        // return Container();

        return Container(
          height: vh * 0.8,
          padding: EdgeInsets.only(
            top: vw * 0.07,
            left: vw * 0.07,
            right: vw * 0.07,
          ),
          decoration: BoxDecoration(
            color: hexaColor('#303030'),
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
                  'Elige un grupo de productos',
                  style: TextStyle(
                    color: hexaColor('#FFFFFF'),
                  ),
                ),
              ),
              SizedBox(
                height: vw * 0.05,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _Item(
                        name: data[index],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: vw * 0.05,
              ),
              _CrearCategoria(vw: vw, miUbicacionBloc: miUbicacionBloc),
            ],
          ),
        );
      },
    );
  }
}

class _CrearCategoria extends StatefulWidget {
  const _CrearCategoria({
    Key key,
    @required this.vw,
    @required this.miUbicacionBloc,
  }) : super(key: key);

  final double vw;
  final MiUbicacionState miUbicacionBloc;

  @override
  __CrearCategoriaState createState() => __CrearCategoriaState();
}

class __CrearCategoriaState extends State<_CrearCategoria> {
  //

  String _nombreCategoria;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            'Si no encuentras un grupo de productos apropiado, puedes crearla',
            style: TextStyle(
              color: hexaColor('#FFFFFF'),
            ),
          ),
        ),
        TextField(
          onChanged: (value) {
            this._nombreCategoria = value;
          },
          style: TextStyle(color: Colors.white),
          maxLength: 30,
          autofocus: false,
          decoration: InputDecoration(
            counterStyle: TextStyle(
              color: hexaColor('#CCCCCC'),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hexaColor('#E6D29F'),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hexaColor('#E6D29F'),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hexaColor('#E6D29F'),
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: hexaColor('#E6D29F'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: widget.vw * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  hexaColor('#DDDDDD'),
                ),
              ),
              onPressed: () {
                //

                print(this._nombreCategoria);

                if (this._nombreCategoria != null &&
                    this._nombreCategoria != '') {
                  DBFirestore().addMyCategori(
                    phoneIdStore: Pref().phone,
                    cityPath: widget.miUbicacionBloc.address,
                    categories: this._nombreCategoria,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Guardar',
                style: TextStyle(
                  color: hexaColor('#303030'),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: widget.vw * 0.03,
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String name;

  _Item({
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
        print('_Item - this.name: ${this.name}');
      },
    );
  }
}
