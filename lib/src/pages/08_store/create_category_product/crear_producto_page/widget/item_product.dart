import 'dart:math';

import 'package:allapp/src/models/list_product.dart';
import 'package:allapp/src/pages/08_store/create_category_product/crear_producto_page/bloc/crear_producto_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

import 'modal_bottom_tienda.dart';

class ItemProduct extends StatefulWidget {
  final int index;
  final String category;
  final ListProductElement data;
  // final QueryDocumentSnapshot<Map<String, dynamic>> data;

  ItemProduct({
    @required this.index,
    @required this.data,
    @required this.category,
    Key key,
  }) : super(key: key);

  @override
  _ItemProductState createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  final colorBase = hexaColor('#ffffff', opacity: 0);
  final colorActivate = hexaColor('#ffffff', opacity: 0.1);

  bool toggleColorLocal;
  bool listOfSelected;
  CrearProductoBloc productoBloc;

  @override
  void initState() {
    super.initState();
    productoBloc = BlocProvider.of<CrearProductoBloc>(context);

    toggleColorLocal = false;
    listOfSelected = false;

    productoBloc.stream.listen((event) {
      listOfSelected = event.mapToggleColor.containsValue(true);

      if (!listOfSelected) {
        toggleColorLocal = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    return Container(
      color: !this.toggleColorLocal ? colorBase : colorActivate,
      // padding: EdgeInsets.symmetric(
      //   vertical: 12,
      // ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Container(
          // height: 80,
          width: 60,
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: rgbColor(r, g, b, 1),
            color: this.widget.data.urlImageProductStore != null
                ? rgbColor(0, 0, 0, 0)
                : hexaColor('#BEA07D'),
          ),
          child: this.widget.data.urlImageProductStore == null
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: SvgPicture.asset('assets/icons/box.svg'),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    height: vw * 0.25,
                    width: vw * 0.25,
                    placeholder: kTransparentImage,
                    image: this.widget.data.urlImageProductStore,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: vw * 0.25,
                        width: vw * 0.25,
                        color: Colors.pink,
                      );
                    },
                  ),
                ),
        ),
        title: Text(
          widget.data.nameProductStore ?? '',
          style: TextStyle(
            color: hexaColor('#DDDDDD'),
          ),
        ),
        onLongPress: () {
          // print(object)
          setState(() {
            this.toggleColorLocal = !this.toggleColorLocal;
            productoBloc
                .add(MapToggleColor({widget.index: this.toggleColorLocal}));
          });
        },
        onTap: () {
          if (listOfSelected) {
            this.toggleColorLocal = !this.toggleColorLocal;
            productoBloc
                .add(MapToggleColor({widget.index: this.toggleColorLocal}));
          } else {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: rgbColor(0, 0, 0, 0),
              barrierColor: rgbColor(0, 0, 0, 0),
              builder: (BuildContext context) {
                return ModalButtomProducto(
                  textButtom: 'MODIFICAR',
                  idProduct: this.widget.data.id,
                  category: widget.category,
                  cantidad: this.widget.data.quantityProductStore,
                  disponibilidad: this.widget.data.availabilityProductStore,
                  nombre: this.widget.data.nameProductStore,
                  precio: this.widget.data.priceProductStore,
                  urlImage: this.widget.data.urlImageProductStore,
                );
              },
            );
          }
        },
      ),
    );
  }
}
