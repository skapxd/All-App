import '../../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../../data/db/db_ver_tienda.dart';
import '../../../models/cache_store_model/cache_store_model.dart';
import '../ver_page_image_comercio/ver_page_image_comercio.dart';
import '../../../utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class Fotos extends StatelessWidget {
  //

  final StoreModel storeModel;

  const Fotos({
    @required this.storeModel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    final double vh = MediaQuery.of(context).size.height;
    return Container(
      height: vw * 0.4,
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

          final data = snapshot.data;

          if (data == null) {
            return Container();
          }

          return ListView.builder(
            itemCount: data.docs.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: vw * 0.4,
                width: vw * 0.25,
                margin: index == 0
                    ? EdgeInsets.only(right: vw * 0.04, left: vw * 0.06)
                    : EdgeInsets.only(right: vw * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  color: hexaColor('#404040'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: data.docs[index].data()['urlImage'],
                      width: vw * 0.25,
                      fit: BoxFit.cover,
                      height: vw * 0.4,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      VerPageImageComercio.pathName,
                      arguments: {'index': index, 'data': data.docs},
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
