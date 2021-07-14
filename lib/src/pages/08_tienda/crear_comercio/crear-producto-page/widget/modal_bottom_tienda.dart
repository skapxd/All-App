import '../../../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../../../data/shared/pref.dart';
import '../../../../../data/storage/storage.dart';
import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/crear_producto_page_bloc.dart';
import 'custom_text_product.dart';
import 'if_swich_formulario_producto.dart';
import 'selected_icon_product.dart';

class ModalButtomProducto extends StatefulWidget {
  final String textButtom;
  final String categori;
  final bool disponibilidad;
  final String nombre;
  final String precio;
  final String cantidad;
  final String idProduct;
  final String urlImage;

  ModalButtomProducto({
    this.nombre,
    this.urlImage,
    this.precio,
    this.cantidad,
    this.idProduct,
    this.disponibilidad,
    @required this.categori,
    @required this.textButtom,
  });

  @override
  _ModalButtomProductoState createState() => _ModalButtomProductoState();
}

class _ModalButtomProductoState extends State<ModalButtomProducto> {
  //

  TextEditingController nombreTextEditingController;
  TextEditingController precioTextEditingController;
  TextEditingController cantidadTextEditingController;

  String nombre;
  String precio;
  String cantidad;
  bool ifDisponible;
  String localPathImageProduct;

  @override
  void initState() {
    //

    nombreTextEditingController = TextEditingController(
      text: widget.nombre,
    );

    precioTextEditingController = TextEditingController(
      text: widget.precio,
    );

    cantidadTextEditingController = TextEditingController(
      text: widget.cantidad,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;
    final double vw = MediaQuery.of(context).size.width;

    final _miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context).state;
    final _productoBloc = BlocProvider.of<CrearProductoBloc>(context);

    return FutureBuilder(
      // future: DBFirestore().getCategory(categories: 'supermercado'),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //

        final data = snapshot.data;

        if (data == null) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Color(0x00000000),
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: hexaColor('#D6D6D6'),
            ),
            sized: false,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: vw * 0.03),
              height: vh * 0.82,
              padding: EdgeInsets.only(
                top: vw * 0.07,
                left: vw * 0.07,
                right: vw * 0.07,
              ),
              decoration: BoxDecoration(
                color: hexaColor('#D6D6D6'),

                // color: hexaColor('#333333'),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(vw * 0.1),
                  topRight: Radius.circular(vw * 0.1),
                ),
              ),
            ),
          );
        }

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0x00000000),
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: hexaColor('#D6D6D6'),
          ),
          sized: false,
          child: Container(
            height: vh * 0.82,
            margin: EdgeInsets.symmetric(horizontal: vw * 0.03),
            padding: EdgeInsets.only(
              top: vw * 0.07,
              left: vw * 0.07,
              right: vw * 0.07,
            ),
            decoration: BoxDecoration(
              // color: hexaColor('#000000'),
              color: hexaColor('#D6D6D6'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(vw * 0.1),
                topRight: Radius.circular(vw * 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectedIconProduct(
                  urlImage: this.widget.urlImage,
                  onSelected: (localPath) {
                    localPathImageProduct = localPath;
                  },
                ),
                SizedBox(
                  height: vw * 0.03,
                ),
                Text(
                  'Agrega una foto del producto',
                  style: TextStyle(
                    color: hexaColor('#3D3D3D', opacity: 0.4),
                  ),
                ),
                SizedBox(
                  height: vw * 0.05,
                ),
                IfSwichFormularioProducto(
                  initialIfEnable: this.widget.disponibilidad,
                  onChanged: (value) {
                    ifDisponible = value;
                    // _productoBloc.add(AddIfDisponibilidad(value));
                  },
                  text: 'Disponibilidad',
                ),
                CustomTextInputProducts(
                  text: 'Nombre',
                  textEditingController: nombreTextEditingController,
                  // initialValue: this.nombre,
                  margin: EdgeInsets.only(bottom: 20),
                  onChange: (String value) {
                    nombre = value;
                    // _productoBloc.add(AddNonbre(value));
                  },
                ),
                CustomTextInputProducts(
                  text: 'Precio',
                  textEditingController: precioTextEditingController,
                  margin: EdgeInsets.only(bottom: 20),
                  onChange: (String value) {
                    precio = value;
                    // _productoBloc.add(AddPrecio(value));
                  },
                  keyboardType: TextInputType.number,
                ),
                CustomTextInputProducts(
                  text: 'Cantidad',
                  textEditingController: cantidadTextEditingController,
                  margin: EdgeInsets.only(bottom: 20),
                  onChange: (String value) {
                    cantidad = value;
                    // _productoBloc.add(AddCantidad(value));
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: vw * 0.05,
                ),
                InkWell(
                  onTap: () {
                    if (nombre != null ||
                        precio != null ||
                        cantidad != null ||
                        _productoBloc.state.pathImageProduct != null ||
                        _productoBloc.state.ifDisponibilidad != null) {
                      //

                      DBFirebaseStorage().uploadImageProduct(
                        phone: Pref().phone,
                        filePath: localPathImageProduct,
                        cityPath: _miUbicacionBloc.address,
                        onSuccess: (url) {
                          // DBFirestore().addProducInMyCategori(
                          //   urlImageProducto: url,
                          //   productName: nombre,
                          //   productPrice: precio,
                          //   productQty: cantidad,
                          //   phoneIdStore: Pref().phone,
                          //   idProduct: this.widget.idProduct,
                          //   categories: this.widget.categori,
                          //   productAvailability: ifDisponible,
                          //   cityPath: _miUbicacionBloc.address,
                          // );

                          // nombreTextEditingController.clear();
                          // precioTextEditingController.clear();
                          // cantidadTextEditingController.clear();

                          nombre = null;
                          precio = null;
                          cantidad = null;
                          ifDisponible = null;
                          localPathImageProduct = null;
                        },
                      );

                      Navigator.pop(context);
                    }
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [
                          hexaColor('#E6D29F'),
                          hexaColor('#E3B97F'),
                        ],
                      ),
                      border: Border.all(
                        color: hexaColor('#232323'),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        this.widget.textButtom,
                        style: TextStyle(letterSpacing: 5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
