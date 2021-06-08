import 'package:allapp/src/data/db/firestore.dart';
import 'package:allapp/src/models/load_json_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';

import 'package:flutter/services.dart' show rootBundle;

class ProductosPage extends StatelessWidget {
  static final String pathName = '/CrearProductosPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: index == 0 ? 70 : 20,
                    ),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: hexaColor('#BEA07D'),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/box.svg',
                          color: hexaColor('#FFDEBD'),
                        ),
                      ),
                      title: Text('Hola'),
                    ),
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

    List categories;

    return FutureBuilder(
      future: DBFirestore().getCategory(categories: 'supermercado'),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //

        final data = snapshot.data;

        data.map((e) {
          categories.add(e);
        });

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
            color: hexaColor('#333333'),
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
                  'Eliga su tipo de comercio',
                  style: TextStyle(
                    color: hexaColor('#FFFFFF'),
                  ),
                ),
              ),
              SizedBox(
                height: vw * 0.01,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _Item(
                        // iconPath: data.supermercado[index].path,
                        name: data[index],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Future loadJsonCategories() async {
  //   //

  //   // final json = await rootBundle.loadString('assets/json/categorias.json');

  //   // print('_ListItems - loadJsonCategories - json: $json');

  //   // final data = loadJsonCategoriesFromJson(json);

  //   // print('_ListItems - loadJsonCategories - data: ${data.supermercado}');

  //   // final data = Firebase

  //   return data;
  // }
}

class _Item extends StatelessWidget {
  // final String iconPath;
  final String name;
  // final _pref = Pref();

  _Item({
    // @required this.iconPath,
    @required this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    // final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context).state;

    // final comercioBloc = BlocProvider.of<ComercioBloc>(context);

    return ListTile(
      title: Text(
        this.name,
        style: TextStyle(
          color: hexaColor('#DDDDDD'),
        ),
      ),
      // leading: Container(
      //   height: 25,
      //   width: 25,
      //   child: SvgPicture.asset(this.iconPath),
      // ),
      onTap: () {
        Navigator.pop(context);
        // comercioBloc.add(AddNombreTipoDeTienda(this.name));
        // comercioBloc.add(AddPathTipoDeTienda(this.iconPath));

        // DBFirestore().removeStore(
        //   categories: _pref.nombreTipoDeTienda,
        //   phoneIdStore: _pref.phone,
        //   cityPath: miUbicacion.address,
        // );

        // _pref.nombreTipoDeTienda = this.name.toLowerCase();
        // _pref.pathTipoDeTienda = this.iconPath.toLowerCase();
      },
    );
  }
}
