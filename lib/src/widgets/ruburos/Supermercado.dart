import 'package:allapp/src/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../data/db/firestore.dart';
import '../../pages/04_home/bloc/home_bloc.dart';
import '../BannerDePago.dart';
import '../BannerInicial.dart';
import '../BloqueDePago/BloqueDePago.dart';
import '../RowShop.dart';
import '../ValorarTiendas.dart';

class Supermercado extends StatefulWidget {
  final String categories;

  const Supermercado({
    @required this.categories,
  });

  @override
  _SupermercadoState createState() => _SupermercadoState();
}

class _SupermercadoState extends State<Supermercado>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state) {
              //

              print('Supermercado ======> MiUbicacionBloc ${state.address}');

              if (state.address == null) {
                return Placeholder();
              }

              return FutureBuilder(
                future: DBFirestore().getListStore(
                  cityPath: state.address,
                  categories: this.widget.categories,
                ),
                // ignore: missing_return
                builder: (BuildContext context,
                    AsyncSnapshot<List<StoreModel>> snapshot) {
                  //
                  final listStoreModel = snapshot.data;

                  print('Supermercado ======> FutureBuilder $listStoreModel');

                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return _PlaceHolder();

                    case ConnectionState.done:
                      return BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          //

                          if (state.tapBarViewIndex != 1) {
                            return Container();
                          }

                          return Column(
                            children: [
                              BannerInicial(),
                              FilaDeSubCategoriaDeTiendas(
                                titleRow: 'RECOMENDADOS POR ALL APP',
                                listStoreModel: listStoreModel,
                                ruburo: 'todo',
                              ),
                              FilaDeSubCategoriaDeTiendas(
                                listStoreModel: listStoreModel,
                                titleRow: 'Mejor calificados',
                                ruburo: 'todo',
                              ),
                              FilaDeSubCategoriaDeTiendas(
                                titleRow: 'más usados esta semana',
                                listStoreModel: listStoreModel,
                                ruburo: 'todo',
                              ),
                              BannerDePago(),
                              FilaDeSubCategoriaDeTiendas(
                                listStoreModel: listStoreModel,
                                titleRow: 'nuevas tiendas',
                                ruburo: 'todo',
                              ),
                              ValorarTiendas(),
                              BloqueDePago(),
                            ],
                          );
                        },
                      );
                  }
                },
              );
            },
          ),
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
      color: Colors.white,
    );
  }
}
