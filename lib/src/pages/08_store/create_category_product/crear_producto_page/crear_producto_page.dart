import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/crear_producto_page_bloc.dart';
import 'widget/item_product.dart';
import 'widget/modal_bottom_tienda.dart';

class CrearProductoPage extends StatelessWidget {
  //

  static final pathName = '/CrearProductoPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    final category = ModalRoute.of(context).settings.arguments;
    final productoBloc = BlocProvider.of<CrearProductoBloc>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0x00000000),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            category,
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
          actions: [
            BlocBuilder<CrearProductoBloc, CrearProductoState>(
              builder: (context, state) {
                if (!state.mapToggleColor.containsValue(true)) {
                  return Container();
                }
                return IconButton(
                  icon: Icon(Icons.delete),
                  // onPressed: () {},
                  onPressed: () {
                    print('CategoryProductPage delete');
                    List<int> deleteGroup = [];
                    deleteGroup.clear();
                    state.mapToggleColor.forEach((key, value) {
                      if (value == true) {
                        deleteGroup.add(key);
                      }
                    });
                    print(deleteGroup);
                    productoBloc
                        .add(DeleteGroupCategories(deleteGroup, context));
                    if (productoBloc.state.mapToggleColor.containsValue(true)) {
                      productoBloc.state.mapToggleColor.forEach((key, value) {
                        print('CategoryProductPage back $key $value');
                        productoBloc.add(MapToggleColor({key: false}));
                      });
                    }
                    // categoryProductBloc.add(DeleteAllCategories());
                  },
                );
              },
            )
          ],
        ),
        backgroundColor: hexaColor('#303030'),
        body: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(left: 20, right: 20),
              child: BlocBuilder<CrearProductoBloc, CrearProductoState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.listProduct.listProduct.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ItemProduct(
                        category: category,
                        index: index,
                        data: state.listProduct.listProduct[index],
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
                    barrierColor: rgbColor(0, 0, 0, 0),
                    builder: (BuildContext context) {
                      return ModalButtomProducto(
                        textButtom: 'AÑADIR PRODUCTO',
                        category: category,
                      );
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
