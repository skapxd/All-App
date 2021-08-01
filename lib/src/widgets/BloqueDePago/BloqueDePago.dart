import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../PageImage.dart';

class BloqueDePago extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        top: vw * 0.02,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Nombre de la empresa'.toUpperCase(),
              style: TextStyle(
                color: hexaColor('#BEA07D'),
                letterSpacing: 3,
                fontSize: vw * 0.03,
              ),
            ),
          ),
          Container(
            height: vw * 0.4,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: index == 0
                      ? EdgeInsets.only(right: vw * 0.04, left: vw * 0.06)
                      : EdgeInsets.only(right: vw * 0.04),
                  height: vw * 0.4,
                  width: vw * 0.25,
                  decoration: BoxDecoration(
                    color: hexaColor('#BEA07D'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PageImage.pathName,
                          arguments: index,
                        );
                      },
                      child: Text('$index'),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: vw * 0.06, top: vw * 0.06),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: vw * 0.2,
                  width: vw * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(vw * 0.05),
                    color: hexaColor('#BBBBBB'),
                  ),
                ),
                SizedBox(
                  width: vw * 0.05,
                ),
                Container(
                  width: vw * 0.4,
                  child: Text(
                    'Eiusmod sunt ut sunt esse cillum do id velit do sint laborum aute ',
                    style: TextStyle(color: hexaColor('#BBBBBB')),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: vw * 0.03,
                    vertical: vw * 0.05,
                  ),
                  // margin: EdgeInsets.,
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    border: Border.all(
                      color: hexaColor('#BEA07D'),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Text(
                      'Ver más',
                      style: TextStyle(
                        color: hexaColor('#BBBBBB'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
