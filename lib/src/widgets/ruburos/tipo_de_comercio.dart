import 'package:flutter/material.dart';

import '../BannerDePago.dart';
import '../BannerInicial.dart';
import '../BloqueDePago/BloqueDePago.dart';
import '../RowShop.dart';
import '../ValorarTiendas.dart';

class HomeTipoDeComercio extends StatefulWidget {
  final String categories;

  const HomeTipoDeComercio({
    @required this.categories,
  });

  @override
  _HomeTipoDeComercioState createState() => _HomeTipoDeComercioState();
}

class _HomeTipoDeComercioState extends State<HomeTipoDeComercio>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          BannerInicial(
            text: widget.categories ?? 'todo',
          ),
          FilaDeSubCategoriaDeTiendas(
            titleRow: 'PATROCINADORES DE ALL APP',
            // listStoreModel: [],
            category: widget.categories,
          ),
          FilaDeSubCategoriaDeTiendas(
            titleRow: 'RECOMENDADOS POR ALL APP',
            // listStoreModel: [],
            category: widget.categories,
          ),
          FilaDeSubCategoriaDeTiendas(
            // listStoreModel: [],
            titleRow: 'Mejor calificados',
            category: widget.categories,
          ),
          FilaDeSubCategoriaDeTiendas(
            titleRow: 'más usados esta semana',
            // listStoreModel: [],
            category: widget.categories,
          ),
          BannerDePago(),
          FilaDeSubCategoriaDeTiendas(
            // listStoreModel: [],
            titleRow: 'nuevas tiendas',
            category: widget.categories,
          ),
          ValorarTiendas(),
          BloqueDePago(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
