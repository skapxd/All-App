import 'package:allapp/src/utils/utils.dart';
import 'package:allapp/src/widgets/BackgroundGradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class HistorialDeClientesPage extends StatelessWidget {
  static final String pathName = '/HistorialDeClientesPage';

  final _textStyle = TextStyle(color: hexaColor('#fefefe'), fontSize: 16);

  final _text =
      """El "Historial de clientes" ordenar en una lista a los clientes por frecuencia de compra o cantidad de dinero gastada en un "Rango de tiempo" que usted escoja. 

Al tocar algún cliente de la lista lo llevara a una pagina donde aparecerá los productos mas comprados por ese cliente.

También podrá seleccionar un "Rango de tiempo" donde podrá evaluar cuanto ha gastado y que productos a comprado en ese tiempo. 

La unidad básica del "Rango De Tiempo" será 1 día, guardando el total de ventas de ese día. 

En una futura actualización, haremos que la unidad básica del "Rango De Tiempo" sea de 1 hora para una mayor precisión a la hora de evaluar las ventas de los productos.

Tambien haremos posible crear descuentos personalizados a los clientes que usted escoja.

Además podrá hacerlo de forma automática, basándose en parámetros (cantidad de dinero gastado en el establecimiento, frecuencia de compra del cliente, entre otros) que usted haya seleccionado.
""";

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
            'HISTORIAL DE CLIENTES',
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
