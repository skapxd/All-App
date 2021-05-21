import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../BannerDePago.dart';
import '../BannerInicial.dart';
import '../BloqueDePago/BloqueDePago.dart';
import '../RowShop.dart';
import '../ValorarTiendas.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    final vw = MediaQuery.of(context).size.width;

    final vh = MediaQuery.of(context).size.height;

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(),
      ]),
    );

    // return SliverList(
    //   delegate: SliverChildListDelegate(
    //     [
    //       BannerInicial(),
    //       FilaDeSubCategoriaDeTiendas(
    //         titleRow: 'RECOMENDADOS POR ALL APP',
    //         ruburo: 'todo',
    //       ),
    //       FilaDeSubCategoriaDeTiendas(
    //         titleRow: 'Mejor calificados',
    //         ruburo: 'todo',
    //       ),
    //       FilaDeSubCategoriaDeTiendas(
    //         titleRow: 'más usados esta semana',
    //         ruburo: 'todo',
    //       ),
    //       BannerDePago(),
    //       FilaDeSubCategoriaDeTiendas(
    //         titleRow: 'nuevas tiendas',
    //         ruburo: 'todo',
    //       ),
    //       ValorarTiendas(),
    //       BloqueDePago(),
    //     ],
    //   ),
    // );
  }

  // Future<ListModelImageUrls> http() async {
  //   try {
  //     var unplash = Dio(BaseOptions(baseUrl: 'https://api.unsplash.com'));
  //     var response2 = await unplash.get('/photos', queryParameters: {
  //       'client_id': 'RbLda7kQtHjEVR52HO9a8BVHtOMEsWQ-4xdrxIF49yM',
  //     });

  //     return ListModelImageUrls.fromJsonList(response2.data);
  //   } catch (e) {
  //     return ListModelImageUrls.fromJsonList([]);
  //   }
  // }
}
