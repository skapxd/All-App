import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/BannerDePago.dart';
import 'package:allapp/src/widgets/BannerInicial.dart';
import 'package:allapp/src/widgets/BloqueDePago/BloqueDePago.dart';
import 'package:allapp/src/widgets/RowShop.dart';
import 'package:allapp/src/widgets/ValorarTiendas.dart';
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
          BannerInicial(),
          // FilaDeSubCategoriaDeTiendas(
          //   subCategoria: 'RECOMENDADOS POR ALL APP',
          //   nameBusiness: [
          //     Business(
          //       '1',
          //       'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
          //     ),
          //     Business(
          //       '12',
          //       '',
          //     ),
          //     Business(
          //       '123',
          //       '',
          //     ),
          //     Business(
          //       '1234',
          //       '',
          //     ),
          //     Business(
          //       '12345',
          //       '',
          //     ),
          //   ],
          // ),
          // FilaDeSubCategoriaDeTiendas(
          //   subCategoria: 'MEJOR CALIFICADOS',
          //   nameBusiness: [
          //     Business(
          //       '123456',
          //       'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
          //     ),
          //     Business(
          //       '1234567 ',
          //       '',
          //     ),
          //     Business(
          //       '12345678 ',
          //       '',
          //     ),
          //     Business(
          //       '12345678 9',
          //       '',
          //     ),
          //     Business(
          //       '12345678 90',
          //       '',
          //     ),
          //   ],
          // ),
          // FilaDeSubCategoriaDeTiendas(
          //   subCategoria: 'MÁS USADOS ESTA SEMANA',
          //   nameBusiness: [
          //     Business(
          //       '123 45 678 910',
          //       'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
          //     ),
          //     Business(
          //       '123 45 678 901',
          //       '',
          //     ),
          //     Business(
          //       '123 45 678 901 2',
          //       '',
          //     ),
          //     Business(
          //       '123 45 678 901 23',
          //       '',
          //     ),
          //     Business(
          //       '123 45 678 901 234',
          //       '',
          //     ),
          //     // 'Nombre del comercio'
          //   ],
          // ),
          // BannerDePago(),
          // FilaDeSubCategoriaDeTiendas(
          //   subCategoria: 'NUEVAS TIENDAS',
          //   nameBusiness: [
          //     Business(
          //       '123456789012345',
          //       'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
          //     ),
          //     Business(
          //       '1234567890123456',
          //       '',
          //     ),
          //     Business(
          //       '12345678901234567',
          //       '',
          //     ),
          //     Business(
          //       '123456789012345678',
          //       '',
          //     ),
          //     Business(
          //       '1234567890123456789',
          //       '',
          //     ),
          //   ],
          // ),
          ValorarTiendas(),
          BloqueDePago(),
        ],
      ),
    );
  }
}
