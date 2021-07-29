import 'package:allapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AnaliticasPage extends StatelessWidget {
  static final String pathName = '/AnaliticasPage';

  final _text =
      """Las "Analiticas" le generara distintas grafica que evaluara los siguientes aspectos de los usuarios

- Tiempo de permanencia en la tienda
- Cantidad de tabs dentro de la tienda
- Lugar donde se visualizo la tienda
- Gustos de los usuarios que visitaron la tienda
- frecuencia de compra del visitante

No se revelara informacion detallada (numero de contacto, nombre, imagen, entre otros) sobre los visitantes.

Los "Usuarios Privados" no apareceran es esta lista.
  """;

  final _styleText = TextStyle(
    color: hexaColor('#fefefe'),
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
        // systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: false,
      child: Scaffold(
        backgroundColor: hexaColor('#303030'),
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          backgroundColor: hexaColor('#353535'),
          title: Text(
            'ANALITICAS',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.5,
              fontSize: 15,
              color: hexaColor('#E6D29F'),
              letterSpacing: 4,
            ),
          ),
          leading: InkWell(
            borderRadius: BorderRadius.circular(vw),
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                'assets/icons/back-arrow.svg',
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  this._text,
                  style: this._styleText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
