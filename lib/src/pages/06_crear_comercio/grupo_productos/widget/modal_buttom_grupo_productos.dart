import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../data/db/firestore.dart';
import '../../../../data/shared/pref.dart';
import '../../../../utils/utils.dart';
import 'title_grupo_producto.dart';

class ModalButtomGrupoProductos extends StatelessWidget {
  //

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
                      return TitleGrupoProductos(
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
            'Si no encuentras un grupo de productos apropiado, puedes crearlo',
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
