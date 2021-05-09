import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/RowShop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BannerInicial(),
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
          FilaDeSubCategoriaDeTiendas(
            subCategoria: 'MÁS USADOS ESTA SEMANA',
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
              // 'Nombre del comercio'
            ],
          ),
          BannerDePago(),
          FilaDeSubCategoriaDeTiendas(
            subCategoria: 'NUEVAS TIENDAS',
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
            ],
          ),
          ValorarTiendas(),
          BloqueDePago(),
        ],
      ),
    );
  }
}

class ValorarTiendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: vw * 0.02),
      child: Column(
        children: [
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
          Container(
            height: vw * 0.3,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: vw * 0.3,
                  color: hexaColor('#BEA07D'),
                  margin: EdgeInsets.only(left: vw * 0.06),
                  width: vw * 0.8,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class BloqueDePago extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
        top: vw * 0.02,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Nombre de la empresa'.toUpperCase(),
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
          ),
          Container(
            height: vw * 0.4,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: index == 0
                      ? EdgeInsets.only(right: vw * 0.04, left: vw * 0.06)
                      : EdgeInsets.only(right: vw * 0.04),
                  height: vw * 0.4,
                  width: vw * 0.25,
                  decoration: BoxDecoration(
                    color: hexaColor('#BEA07D'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: vw * 0.06, top: vw * 0.06),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: vw * 0.2,
                  width: vw * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(vw * 0.05),
                    color: hexaColor('#BBBBBB'),
                  ),
                ),
                SizedBox(
                  width: vw * 0.05,
                ),
                Container(
                  width: vw * 0.4,
                  child: Text(
                    'Eiusmod sunt ut sunt esse cillum do id velit do sint laborum aute ',
                    style: TextStyle(color: hexaColor('#BBBBBB')),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: vw * 0.05,
                    vertical: vw * 0.045,
                  ),

                  // margin: EdgeInsets.,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: hexaColor('#BEA07D'),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Text(
                      'Ver más',
                      style: TextStyle(
                        color: hexaColor('#BBBBBB'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BannerInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: vw * 0.05),
        height: vw * 0.3,
        width: vw * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: hexaColor('#BEA07D'),
        ),
      ),
    );
  }
}

class BannerDePago extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      height: vw * 0.3,
      margin: EdgeInsets.symmetric(vertical: vw * 0.02),
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
    );
  }
}
