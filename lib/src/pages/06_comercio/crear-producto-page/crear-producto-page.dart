import 'package:allapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrearProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PRODUCTOS',
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
    );
  }
}
