import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/RowShop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Supermercado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            alignment: Alignment.center,
            // color: Colors.red,
            // margin: EdgeInsets.zero,

            // height: vw * 0.3,
            child: Container(
              // margin: EdgeInsets.only(left: vw * 0.07),
              margin: EdgeInsets.only(top: vw * 0.05),
              // margin: EdgeInsets.symmetric(horizontal: vw * 0.09),
              height: vw * 0.3,
              width: vw * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: hexaColor('#BEA07D'),
              ),
            ),
          ),
          FilaDeSubCategoriaDeTiendas(
            subCategoria: 'RECOMENDADOS POR ALL APP',
            nameBusiness: [
              Business(
                '1',
                'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
              ),
              Business(
                '12',
                '',
              ),
              Business(
                '123',
                '',
              ),
              Business(
                '1234',
                '',
              ),
              Business(
                '12345',
                '',
              ),
            ],
          ),
          FilaDeSubCategoriaDeTiendas(
            subCategoria: 'MEJOR CALIFICADOS',
            nameBusiness: [
              Business(
                '123456',
                'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
              ),
              Business(
                '1234567 ',
                '',
              ),
              Business(
                '12345678 ',
                '',
              ),
              Business(
                '12345678 9',
                '',
              ),
              Business(
                '12345678 90',
                '',
              ),
            ],
          ),
          ListTile(
            title: Text(
              'MÁS USADOS ESTA SEMANA',
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
            trailing: Container(
              // margin: EdgeInsets.only(right: vw * 0.05),
              child: SvgPicture.asset(
                'assets/icons/next.svg',
                width: vw * 0.07,
              ),
            ),
          ),
          FilaDeTiendas(
            nameBusiness: [
              Business(
                '123 45 678 910',
                'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
              ),
              Business(
                '123 45 678 901',
                '',
              ),
              Business(
                '123 45 678 901 2',
                '',
              ),
              Business(
                '123 45 678 901 23',
                '',
              ),
              Business(
                '123 45 678 901 234',
                '',
              ),
              // 'Nombre del comercio',
            ],
          ),
          ListTile(
            title: Text(
              'NUEVAS TIENDAS',
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
            trailing: Container(
              // margin: EdgeInsets.only(right: vw * 0.05),
              child: SvgPicture.asset(
                'assets/icons/next.svg',
                width: vw * 0.07,
              ),
            ),
          ),
          FilaDeTiendas(
            nameBusiness: [
              Business(
                '123456789012345',
                'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
              ),
              Business(
                '1234567890123456',
                '',
              ),
              Business(
                '12345678901234567',
                '',
              ),
              Business(
                '123456789012345678',
                '',
              ),
              Business(
                '1234567890123456789',
                '',
              ),
              // 'Nombre del comercio',
            ],
          ),
          ListTile(
            title: Text(
              'CUENTANOS QUE PIENSAS',
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
          ),
          FilaDeTiendas(
            nameBusiness: [
              Business(
                'Nombre del comercio',
                'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
              ),
              Business(
                'Nombre d del comercio',
                '',
              ),
              Business(
                'Nombre d del comercio',
                '',
              ),
              Business(
                'Nombre d del comercio',
                '',
              ),
              Business(
                'Nombre d del comercio',
                '',
              ),
            ],
          ),
          ListTile(
            title: Text(
              'BANNER DE PAGO',
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
          ),
          Container(
            height: vw * 0.3,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: vw * 0.07),
                  // margin: EdgeInsets.symmetric(horizontal: vw * 0.09),
                  height: vw * 0.3,
                  width: vw * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: hexaColor('#BEA07D'),
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text(
              'BLOQUE DE PAGO',
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
