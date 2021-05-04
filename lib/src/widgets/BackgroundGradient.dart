import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';

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

    return Container(
      height: vh,
      width: vw,
      color: hexaColor('#232323'),
      child: child,
    );
  }
}
