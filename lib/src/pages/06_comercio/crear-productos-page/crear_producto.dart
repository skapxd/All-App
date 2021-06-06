import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';

class CrearProductosPage extends StatelessWidget {
  static final String pathName = '/CrearProductosPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CREAR PRODUCTOS',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: hexaColor('#E6D29F'),
            letterSpacing: 5,
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
        elevation: 0,
        centerTitle: true,
        backgroundColor: hexaColor('#303030'),
      ),
      // backgroundColor: hexaColor('#303030'),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: rgbColor(0, 0, 0, 0),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: hexaColor('#303030'),
        ),
        child: ExpandChild(
          child: Column(
            children: <Widget>[
              OutlineButton(
                child: Text('Button1'),
                onPressed: () => print('Pressed button1'),
              ),
              OutlineButton(
                child: Text('Button2'),
                onPressed: () => print('Pressed button2'),
              ),
              OutlineButton(
                child: Text('Button3'),
                onPressed: () => print('Pressed button3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
