import 'package:flutter/material.dart';

import '../utils/utils.dart';

class BannerInicial extends StatelessWidget {
  final String text;

  BannerInicial({
    this.text,
  });

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
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
