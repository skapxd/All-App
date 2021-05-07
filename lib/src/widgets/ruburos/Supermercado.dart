import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/RowShop.dart';
import 'package:flutter/material.dart';

class Supermercado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RowShop(
      nameBusiness: [
        Business(
          'Nombre del comercio',
          'https://www.sharethis.com/wp-content/uploads/2017/05/WhatsApp.png',
        ),
        Business(
          'Nombre d del comercio',
          '',
        ),
        // 'Nombre del comercio',
      ],
    );
  }
}
