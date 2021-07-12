import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../data/db/firestore.dart';
import '../../models/cache_store_model/cache_store_model.dart';
import '../../pages/04_home/bloc/home_bloc.dart';
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

    return BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
      builder: (context, state) {
        //

        if (state.address == null) {
          return _PlaceHolder();
        }

        print('HomeTipoDeComercio - MiUbicacionBloc ${state.address.country}');

        print('HomeTipoDeComercio - Categori ${widget.categories}');

        return FutureBuilder(
          future: DBFirestore().getListCategoriesStore(
            cityPath: state.address,
            categories: this.widget.categories,
          ),
          // ignore: missing_return
          builder: (
            BuildContext context,
            AsyncSnapshot<List<StoreModel>> snapshot,
          ) {
            //

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return _PlaceHolder();

              case ConnectionState.done:
                final List<StoreModel> listStoreModel = snapshot.data;

                print(
                  'HomeTipoDeComercio - listStoreModel: $listStoreModel',
                );

                // print(
                //   'HomeTipoDeComercio - ${listStoreModel}',
                // );

                return BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    //

                    // if (listStoreModel.isEmpty) {
                    //   return Container();
                    // }

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          BannerInicial(
                            text: widget.categories,
                          ),
                          FilaDeSubCategoriaDeTiendas(
                            titleRow: 'RECOMENDADOS POR ALL APP',
                            listStoreModel: listStoreModel,
                            categories: widget.categories,
                          ),
                          FilaDeSubCategoriaDeTiendas(
                            listStoreModel: listStoreModel,
                            titleRow: 'Mejor calificados',
                            categories: widget.categories,
                          ),
                          FilaDeSubCategoriaDeTiendas(
                            titleRow: 'más usados esta semana',
                            listStoreModel: listStoreModel,
                            categories: widget.categories,
                          ),
                          BannerDePago(),
                          FilaDeSubCategoriaDeTiendas(
                            listStoreModel: listStoreModel,
                            titleRow: 'nuevas tiendas',
                            categories: widget.categories,
                          ),
                          ValorarTiendas(),
                          BloqueDePago(),
                        ],
                      ),
                    );
                  },
                );
            }
          },
        );
      },
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
