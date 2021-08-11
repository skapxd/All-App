import '../../../utils/utils.dart';

import 'widget/title_grupo_producto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/create_category_product_bloc.dart';
import 'widget/modal_buttom_grupo_productos.dart';
import 'widget/single_categorie.dart';

class CategoryProductPage extends StatelessWidget {
  static final String pathName = '/CategoryProductPage';

  // final colorBase = hexaColor('#ffffff', opacity: 0);
  // final colorActivate = hexaColor('#ffffff', opacity: 1);

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    final categoryProductBloc =
        BlocProvider.of<CreateCategoryProductBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CATEGORIAS',
          // textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: hexaColor('#E6D29F'),
            letterSpacing: 5,
          ),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(vw),
          onTap: () {
            if (categoryProductBloc.state.mapToggleColor.containsValue(true)) {
              categoryProductBloc.state.mapToggleColor.forEach((key, value) {
                print('CategoryProductPage back $key $value');
                categoryProductBloc.add(MapToggleColor({key: false}));
              });
            } else {
              Navigator.pop(context);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
            ),
          ),
        ),
        actions: [
          BlocBuilder<CreateCategoryProductBloc, CreateCategoryProductState>(
            builder: (context, state) {
              if (!state.mapToggleColor.containsValue(true)) {
                return Container();
              }
              return IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('CategoryProductPage delete');
                  List<int> deleteGroup = [];
                  deleteGroup.clear();
                  state.mapToggleColor.forEach((key, value) {
                    if (value == true) {
                      deleteGroup.add(key);
                    }
                  });
                  categoryProductBloc.add(DeleteGroupCategories(deleteGroup));
                  if (categoryProductBloc.state.mapToggleColor
                      .containsValue(true)) {
                    categoryProductBloc.state.mapToggleColor
                        .forEach((key, value) {
                      print('CategoryProductPage back $key $value');
                      categoryProductBloc.add(MapToggleColor({key: false}));
                    });
                  }
                  // categoryProductBloc.add(DeleteAllCategories());
                },
              );
            },
          )
        ],
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
              child: BlocBuilder<CreateCategoryProductBloc,
                  CreateCategoryProductState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.listCategory.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TitleGrupoProductos(
                        name: categoryProductBloc.state.listCategory[index],
                        index: index,
                        category: categoryProductBloc.state.listCategory[index],
                        // color: ,
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
                      return ModalButtomGrupoProductos();
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
