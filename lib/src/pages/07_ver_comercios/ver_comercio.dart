import '../04_home/store_page/widgets/row_store.dart';

import '../../models/store_model.dart';

import '../../data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
// import '../../models/cache_store_model/cache_store_model.dart';
import 'ver_galeria_fotos/ver_galeria_fotos.dart';
import 'ver_mapa_page/ver_mapa_page.dart';
import 'widget/comprar.dart';
import 'widget/custom_list_title.dart';
import 'widget/fotos.dart';
import 'widget/logo.dart';
import '../../utils/utils.dart';
import '../../widgets/BackgroundGradient.dart';
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

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final StoreModel data = args['storeModel'];

    final String ruburo = args['ruburo'];

    List<String> nameSplit = data.nameStore.split('');

    if (nameSplit.length > 17) {
      nameSplit.insert(16, '\n');
    }

    String description;

    if (data.descriptionStore.length >= 90) {
      description = data.descriptionStore.substring(0, 90) + '...';
    } else {
      description = data.descriptionStore;
    }

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
                      onTap: () {},
                      storeModel: data,
                      ruburo: ruburo,
                      url: data.urlImageStore,
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
                onTap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: vw * 0.06),
                child: Text(
                  description,
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
              // BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
              //   builder: (context, state) {
              //     //

              //     if (state.address == null) {
              //       return _PlaceHolder();
              //     }

              //     return FutureBuilder(
              //       // future: DBFirestore().getListCategoriesStore(
              //       //   cityPath: state.address,
              //       //   categories: ruburo,
              //       // ),
              //       // ignore: missing_return
              //       builder: (
              //         BuildContext context,
              //         AsyncSnapshot<List<StoreModel>> snapshot,
              //       ) {
              //         //

              //         switch (snapshot.connectionState) {
              //           case ConnectionState.none:
              //           case ConnectionState.active:
              //           case ConnectionState.waiting:
              //             return _PlaceHolder();

              //           case ConnectionState.done:
              //             final List<StoreModel> listStoreModel = snapshot.data;

              //             return RowStore(
              //               // nameBusiness: this.nameBusiness,
              //               // listStoreModel: listStoreModel,
              //               addressModel: ,
              //               category: ruburo,
              //             );
              //         }
              //       },
              //     );
              //   },
              // ),
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
              data.contactStore.phoneCall == null ||
                      data.contactStore.phoneCall == ''
                  ? Container()
                  : _Contact(
                      iconPath: 'assets/icons/call.svg',
                      text: data.contactStore.phoneCall,
                      onTap: () async {
                        final _url = Uri(
                          scheme: 'tel',
                          path: data.contactStore.phoneCall.replaceAll(' ', ''),
                        ).toString();

                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw 'Could not launch $_url';
                      },
                    ),
              data.contactStore.whatsApp == null ||
                      data.contactStore.whatsApp == ''
                  ? Container()
                  : _Contact(
                      onTap: () async {
                        final _url = Uri(
                          scheme: 'https',
                          host: 'api.whatsapp.com',
                          path: '/send',
                          queryParameters: {
                            'phone': '57' +
                                data.contactStore.whatsApp.replaceAll(' ', ''),
                            'text': '',
                            'app_absent': '0'
                          },
                        ).toString();

                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw 'Could not launch $_url';
                      },
                      iconPath: 'assets/icons/whatsapp.svg',
                      text: data.contactStore.whatsApp,
                    ),
              data.contactStore.telegram == null ||
                      data.contactStore.telegram == ''
                  ? Container()
                  : _Contact(
                      iconPath: 'assets/icons/telegram.svg',
                      text: data.contactStore.telegram,
                      onTap: () async {
                        final _url = Uri(
                          scheme: 'https',
                          host: 't.me',
                          path: data.contactStore.telegram.replaceAll('@', ''),
                        ).toString();

                        await canLaunch(_url)
                            ? await launch(_url)
                            : throw 'Could not launch $_url';
                      },
                    ),
              data.addressStore.isEmpty
                  ? Container()
                  : _Contact(
                      iconPath: 'assets/icons/lat-lan.svg',
                      text: '',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          VerMapaPage.pathName,
                          arguments: {
                            'latLng': data.addressStore[0].latLngStore
                          },
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
