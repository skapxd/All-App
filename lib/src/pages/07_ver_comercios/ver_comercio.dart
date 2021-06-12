import 'package:allapp/src/models/cache_store_model/cache_store_model.dart';
import 'package:allapp/src/pages/07_ver_comercios/ver_galeria_fotos/ver_galeria_fotos.dart';
import 'package:allapp/src/pages/07_ver_comercios/widget/comprar.dart';
import 'package:allapp/src/pages/07_ver_comercios/widget/custom_list_title.dart';
import 'package:allapp/src/pages/07_ver_comercios/widget/fotos.dart';
import 'package:allapp/src/pages/07_ver_comercios/widget/logo.dart';
import 'package:allapp/src/utils/utils.dart';
import 'package:allapp/src/widgets/BackgroundGradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              padding: EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 3),
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
              padding: EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 3),
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
            SizedBox(
              height: 30,
            ),
            CustomListTile(
              iconWith: 20,
              title: 'CONTACTOS',
              iconPath: 'assets/icons/arrow_down.svg',
              padding: EdgeInsets.symmetric(horizontal: vw * 0.06, vertical: 3),
              onTap: () {
                print('object');
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: vw * 0.06),
              child: Column(
                children: [
                  _Contact(
                    iconPath: 'assets/icons/whatsapp.svg',
                    text: data.phoneWhatsApp,
                  ),
                  _Contact(
                    iconPath: 'assets/icons/whatsapp.svg',
                    text: data.phoneWhatsApp,
                  ),
                  _Contact(
                    iconPath: 'assets/icons/whatsapp.svg',
                    text: data.phoneWhatsApp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact({
    Key key,
    @required this.iconPath,
    @required this.text,
  }) : super(key: key);

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        )
      ],
    );
  }
}
