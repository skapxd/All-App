import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/data/db/db_ver_tienda.dart';
import 'package:allapp/src/models/cache_store_model/cache_store_model.dart';
import 'package:allapp/src/pages/07_ver_comercios/ver_page_image_comercio/ver_page_image_comercio.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:allapp/src/widgets/page_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

class VerGaleriaFotos extends StatefulWidget {
  static final String pathName = '/VerGaleriaFotos';

  @override
  _VerGaleriaFotosState createState() => _VerGaleriaFotosState();
}

class _VerGaleriaFotosState extends State<VerGaleriaFotos> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print('ScrollListener ${_scrollController.offset}');
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    final StoreModel storeModel = args['storeModel'];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'IMAGENES',
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
              stream: DBVerTiendas().verFotos(
                cityPath: miUbicacionBloc.state.address,
                phoneIdStore: storeModel.id,
              ),
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                //

                if (snapshot.data == null) {
                  return Container();
                }

                // final data = snapshot.data.docs;
                final data = snapshot.data.docs;

                return StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  crossAxisCount: 4,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  staggeredTileBuilder: (int index) {
                    // double size
                    return StaggeredTile.count(
                      2,
                      index.isOdd ? 3 : 3.3,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) =>
                      new Container(
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? hexaColor('#D6D6D6', opacity: 0.5)
                          : hexaColor('#D6D6D6', opacity: 0.3),
                      borderRadius: BorderRadius.circular(vw * 0.07),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(vw * 0.07),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          VerPageImageComercio.pathName,
                          arguments: {'index': index, 'data': data},
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(vw * 0.07),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: data[index].data()['urlImage'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
