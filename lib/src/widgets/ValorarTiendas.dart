import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ValorarTiendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: vw * 0.02),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'CUENTANOS QUE PIENSAS',
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
          ),
          Container(
            height: vw * 0.3,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: vw * 0.3,
                  color: hexaColor('#BEA07D'),
                  margin: EdgeInsets.only(left: vw * 0.06),
                  width: vw * 0.8,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
