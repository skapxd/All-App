import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../../data/db/firestore.dart';
import '../../models/cache_store_model/cache_store_model.dart';
import 'ver_galeria_fotos/ver_galeria_fotos.dart';
import 'ver_mapa_page/ver_mapa_page.dart';
import 'widget/comprar.dart';
import 'widget/custom_list_title.dart';
import 'widget/fotos.dart';
import 'widget/logo.dart';
import '../../utils/utils.dart';
import '../../widgets/BackgroundGradient.dart';
import '../../widgets/RowShop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class VerComercios extends StatelessWidget {
  static final String pathName = '/VerComercios';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final StoreModel data = args['storeModel'];

    final String ruburo = args['ruburo'];

    List<String> nameSplit = data.nameStore.split('');

    if (nameSplit.length > 17) {
      nameSplit.insert(16, '\n');
    }

    print(nameSplit.length);

    return Scaffold(
      body: CustomBackgroundGradient(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: vw * 0.06),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Logo(
                      onTap: () {
                        print('object');
                      },
                      storeModel: data,
                      ruburo: ruburo,
                      url: data.urlImage,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      nameSplit.join(''),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hexaColor(
                          '#dddddd',
                        ),
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Comprar(
                onTap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: 'FOTOS',
                padding:
                    EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 3),
                onTap: () {
                  print('object');
                  Navigator.pushNamed(
                    context,
                    VerGaleriaFotos.pathName,
                    arguments: {'storeModel': data},
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              Fotos(
                storeModel: data,
              ),
              SizedBox(
                height: 30,
              ),
              CustomListTile(
                title: 'DESCRIPCIÓN',
                // subTitle: 'Conoce más acerca de este comercio aquí.',
                padding:
                    EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 3),
                onTap: () {
                  print('object');
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: vw * 0.06),
                child: Text(
                  'Nisi excepteur id laboris quis tempor. Incididunt sit excepteur dolor mollit mollit nostrud qui est laboris nostrud dolor non velit dolore. Qui culpa aute sunt officia Lorem. Aliquip Lorem non excepteur sunt ipsum sint pariatur deserunt fugiat in qui eiusmod proident quis. Consequat cupidatat deserunt nisi quis tempor velit aliquip occaecat aliquip culpa.'
                          .substring(0, 90) +
                      '...',
                  style: TextStyle(color: hexaColor('#777777')),
                ),
              ),
              _Links(data: data),
              SizedBox(
                height: 30,
              ),
              CustomListTile(
                iconWith: 20,
                title: 'TIENDAS SIMILARES',
                padding:
                    EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 3),
              ),
              BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
                builder: (context, state) {
                  //

                  if (state.address == null) {
                    return _PlaceHolder();
                  }

                  print(
                      'VerComercios - MiUbicacionBloc ${state.address.country}');

                  print('VerComercios - Categori $ruburo');

                  return FutureBuilder(
                    future: DBFirestore().getListCategoriesStore(
                      cityPath: state.address,
                      categories: ruburo,
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
                            'VerComercios - listStoreModel: $listStoreModel',
                          );

                          // print(
                          //   'VerComercios - ${listStoreModel}',
                          // );

                          return FilaDeTiendas(
                            // nameBusiness: this.nameBusiness,
                            listStoreModel: listStoreModel,
                            ruburo: ruburo,
                          );

                        // return FilaDeSubCategoriaDeTiendas(
                        //   titleRow: 'TIENDAS SIMILARES',
                        //   listStoreModel: listStoreModel,
                        //   categories: ruburo,
                        // );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Links extends StatelessWidget {
  const _Links({
    Key key,
    @required this.data,
  }) : super(key: key);

  final StoreModel data;

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        CustomListTile(
          iconWith: 20,
          title: 'CONTACTOS',
          iconPath: 'assets/icons/arrow_down.svg',
          padding: EdgeInsets.symmetric(horizontal: vw * 0.06),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 0),
          // color: Colors.red,
          child: Column(
            children: [
              data.phoneCall == null || data.phoneCall == ''
                  ? Container()
                  : _Contact(
                      iconPath: 'assets/icons/call.svg',
                      text: data.phoneCall,
                      onTap: () async {
                        final _url = Uri(
                          scheme: 'tel',
                          path: data.phoneCall.replaceAll(' ', ''),
                        ).toString();

                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw 'Could not launch $_url';
                      },
                    ),
              data.phoneWhatsApp == null || data.phoneWhatsApp == ''
                  ? Container()
                  : _Contact(
                      onTap: () async {
                        final _url = Uri(
                          scheme: 'https',
                          host: 'api.whatsapp.com',
                          path: '/send',
                          queryParameters: {
                            'phone':
                                '57' + data.phoneWhatsApp.replaceAll(' ', ''),
                            'text': '',
                            'app_absent': '0'
                          },
                        ).toString();

                        print(_url);
                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw 'Could not launch $_url';
                      },
                      iconPath: 'assets/icons/whatsapp.svg',
                      text: data.phoneWhatsApp,
                    ),
              data.telegram == null || data.telegram == ''
                  ? Container()
                  : _Contact(
                      iconPath: 'assets/icons/telegram.svg',
                      text: data.telegram,
                      onTap: () async {
                        final _url = Uri(
                          scheme: 'https',
                          host: 't.me',
                          path: data.telegram.replaceAll('@', ''),
                        ).toString();

                        print(_url);
                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw 'Could not launch $_url';
                      },
                    ),
              data.direccion == null || data.direccion == ''
                  ? Container()
                  : _Contact(
                      iconPath: 'assets/icons/lat-lan.svg',
                      text: data.direccion,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          VerMapaPage.pathName,
                          arguments: {'latLng': data.latLng},
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact({
    Key key,
    @required this.iconPath,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  final String iconPath;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return MaterialButton(
      // padding: EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 0),
      onPressed: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            this.iconPath,
            width: 20,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            this.text,
            style: TextStyle(
              color: hexaColor('#d5d5d5'),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.pink,
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                'assets/icons/next.svg',
                width: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
