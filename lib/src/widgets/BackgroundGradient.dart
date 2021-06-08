import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomBackgroundGradient extends StatelessWidget {
  final Widget child;

  CustomBackgroundGradient({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    final pixel = MediaQuery.of(context).devicePixelRatio;

    return Container(
      height: vh,
      width: vw,
      color: hexaColor('#232323'),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/img/bg.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: child,
    );
  }
}
