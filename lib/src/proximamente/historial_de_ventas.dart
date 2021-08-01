import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class HistorialDeVentasPage extends StatelessWidget {
  static final String pathName = '/HistorialDeVentasPage';

  final _textStyle = TextStyle(
    color: hexaColor('#fefefe'),
    fontSize: 16,
  );

  final _text =
      """El "Historial de ventas" ordenará los productos por cantidad  de ventas en un "Rango De Tiempo" de su elección. 

Los productos se mostrarán en una gráfica donde se podrá apreciar que productos se venden más y que productos se venden menos.

La unidad básica del "Rango De Tiempo" será de 1 día, guardando el total de ventas de ese día. 

En una futura actualización, haremos que la unidad básica del "Rango De Tiempo" sea de 1 hora para una mayor precisión a la hora de evaluar las ventas de los productos.
""";

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;

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
            'HISTORIAL DE VENTAS',
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
                  style: this._textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
