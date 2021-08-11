import 'package:flutter/material.dart';

import '../../../../widgets/BannerDePago.dart';
import '../../../../widgets/BannerInicial.dart';
import '../../../../widgets/BloqueDePago/BloqueDePago.dart';
import 'row_store.dart';
import '../../../../widgets/ValorarTiendas.dart';

class CategoryStore extends StatefulWidget {
  final String categories;

  const CategoryStore({
    @required this.categories,
  });

  @override
  _CategoryStoreState createState() => _CategoryStoreState();
}

class _CategoryStoreState extends State<CategoryStore>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          BannerInicial(
            text: widget.categories ?? 'todo',
          ),
          TitleRowStore(
            titleRow: 'PATROCINADORES DE ALL APP',
            // listStoreModel: [],
            category: widget.categories,
          ),
          TitleRowStore(
            titleRow: 'RECOMENDADOS POR ALL APP',
            // listStoreModel: [],
            category: widget.categories,
          ),
          TitleRowStore(
            // listStoreModel: [],
            titleRow: 'Mejor calificados',
            category: widget.categories,
          ),
          TitleRowStore(
            titleRow: 'más usados esta semana',
            // listStoreModel: [],
            category: widget.categories,
          ),
          BannerDePago(),
          TitleRowStore(
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
