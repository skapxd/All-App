import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/images.dart';
import '../../utils/utils.dart';
import '../BannerDePago.dart';
import '../BannerInicial.dart';
import '../BloqueDePago/BloqueDePago.dart';
import '../RowShop.dart';
import '../ValorarTiendas.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BannerInicial(),
          FutureBuilder(
            future: http(),
            builder: (context, AsyncSnapshot<ListModelImageUrls> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return FilaDeSubCategoriaDeTiendas(
                    subCategoria: 'RECOMENDADOS POR ALL APP',
                    itemCount: snapshot.data.items.length,
                    nameBusiness: snapshot.data,
                    ruburo: 'Supermercado',
                  );
                  break;

                case ConnectionState.active:
                case ConnectionState.none:
                case ConnectionState.waiting:
                default:
                  return PlaceHolderOfFilaDeSubCategoriaDeTiendas(
                    nombre: 'RECOMENDADOS POR ALL APP',
                  );
              }
            },
          ),
          FutureBuilder(
            future: http(),
            builder: (context, AsyncSnapshot<ListModelImageUrls> snapshot) {
              // print(snapshot);

              if (snapshot.data == null) {
                return PlaceHolderOfFilaDeSubCategoriaDeTiendas(
                  nombre: 'Mejor calificados',
                );
              } else {
                return FilaDeSubCategoriaDeTiendas(
                  subCategoria: 'Mejor calificados',
                  itemCount: snapshot.data.items.length,
                  nameBusiness: snapshot.data,
                  ruburo: 'Supermercado',
                );
              }
            },
          ),
          FutureBuilder(
            future: http(),
            builder: (context, AsyncSnapshot<ListModelImageUrls> snapshot) {
              // print(snapshot);

              if (snapshot.data == null) {
                return PlaceHolderOfFilaDeSubCategoriaDeTiendas(
                  nombre: 'más usados esta semana',
                );
              } else {
                return FilaDeSubCategoriaDeTiendas(
                  subCategoria: 'más usados esta semana',
                  itemCount: snapshot.data.items.length,
                  nameBusiness: snapshot.data,
                  ruburo: 'Supermercado',
                );
              }
            },
          ),
          BannerDePago(),
          FutureBuilder(
            future: http(),
            builder: (context, AsyncSnapshot<ListModelImageUrls> snapshot) {
              // print(snapshot);

              if (snapshot.data == null) {
                return PlaceHolderOfFilaDeSubCategoriaDeTiendas(
                  nombre: 'nuevas tiendas',
                );
              } else {
                return FilaDeSubCategoriaDeTiendas(
                  subCategoria: 'nuevas tiendas',
                  itemCount: snapshot.data.items.length,
                  nameBusiness: snapshot.data,
                  ruburo: 'Supermercado',
                );
              }
            },
          ),
          ValorarTiendas(),
          BloqueDePago(),
        ],
      ),
    );
  }

  Future<ListModelImageUrls> http() async {
    try {
      var unplash = Dio(BaseOptions(baseUrl: 'https://api.unsplash.com'));
      var response2 = await unplash.get('/photos', queryParameters: {
        'client_id': 'RbLda7kQtHjEVR52HO9a8BVHtOMEsWQ-4xdrxIF49yM',
      });

      return ListModelImageUrls.fromJsonList(response2.data);
    } catch (e) {
      return ListModelImageUrls.fromJsonList([]);
    }
  }
}

class PlaceHolderOfFilaDeSubCategoriaDeTiendas extends StatelessWidget {
  final String nombre;

  const PlaceHolderOfFilaDeSubCategoriaDeTiendas({@required this.nombre});

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      // height: vw * 0.4,
      margin: EdgeInsets.only(top: vw * 0.02),
      child: Column(
        children: [
          Container(
            // height: vw * 0.38,

            child: ListTile(
              title: Text(
                this.nombre.toUpperCase(),
                style: TextStyle(
                  color: hexaColor('#BEA07D'),
                  letterSpacing: 3,
                  fontSize: vw * 0.03,
                ),
              ),
              trailing: Container(
                child: SvgPicture.asset(
                  'assets/icons/next.svg',
                  width: vw * 0.07,
                ),
              ),
            ),
          ),
          Container(
            height: vw * 0.39,
            child: Row(
              children: [
                _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem(),
                _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem(),
                _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        left: vw * 0.05,
        top: vw * 0.02,
        right: vw * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: vw * 0.25,
                  width: vw * 0.24,
                  decoration: BoxDecoration(
                    color: hexaColor('#303030'),
                    boxShadow: [
                      BoxShadow(
                        color: rgbColor(0, 0, 0, 0.2),
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(vw * 0.05),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: vw * 0.01),
            child: Text(
              '....',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: hexaColor('#8C8C8C'),
                fontSize: vw * 0.03,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                '4.5',
                style: TextStyle(color: hexaColor('#DDDDDD'), fontSize: 10),
              ),
              SizedBox(width: 3),
              SvgPicture.asset(
                'assets/icons/full-star.svg.svg',
                height: 7,
              ),
            ],
          )
        ],
      ),
    );
  }
}
