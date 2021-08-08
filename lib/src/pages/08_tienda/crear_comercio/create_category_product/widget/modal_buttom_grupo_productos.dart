import 'package:allapp/src/data/shared/produc_store_pref/product_store_pref.dart';
import 'package:allapp/src/pages/08_tienda/crear_comercio/create_category_product/bloc/create_category_product_bloc.dart';

import '../../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalButtomGrupoProductos extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;
    final double vw = MediaQuery.of(context).size.width;
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;
    final categoryProductBloc =
        BlocProvider.of<CreateCategoryProductBloc>(context);

    return Container(
      height: vh * 0.3,
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
          SizedBox(
            height: vw * 0.05,
          ),
          _CrearCategoria(
            vw: vw,
            miUbicacionBloc: miUbicacionBloc,
            onPress: (value) {
              Navigator.pop(context);
              categoryProductBloc.add(AddCategory(value));
            },
          ),
        ],
      ),
    );
  }
}

class _CrearCategoria extends StatefulWidget {
  _CrearCategoria({
    Key key,
    @required this.vw,
    @required this.miUbicacionBloc,
    this.onPress,
  }) : super(key: key);

  final double vw;
  final MiUbicacionState miUbicacionBloc;
  final void Function(String value) onPress;

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
            'Crear categoria',
            // 'Si no encuentras un grupo de productos apropiado, puedes crearlo',
            textAlign: TextAlign.left,
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
          autofocus: true,
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

                if (this._nombreCategoria != null &&
                    this._nombreCategoria != '') {
                  // DBFirestore().addMyCategori(
                  //   phoneIdStore: Pref().phone,
                  //   cityPath: widget.miUbicacionBloc.address,
                  //   categories: this._nombreCategoria,
                  // );

                  if (widget.onPress != null) {
                    widget.onPress(this._nombreCategoria);
                  }
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
