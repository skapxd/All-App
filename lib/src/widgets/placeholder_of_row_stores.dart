import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';

class PlaceHolderOfFilaDeSubCategoriaDeTiendas extends StatelessWidget {
  final String nombre;

  const PlaceHolderOfFilaDeSubCategoriaDeTiendas({@required this.nombre});

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return Container(
      // height: vw * 0.4,
      margin: EdgeInsets.only(top: vw * 0.02),
      child: Column(
        children: [
          Container(
            // height: vw * 0.38,

            child: ListTile(
              title: Text(
                this.nombre.toUpperCase(),
                style: TextStyle(
                  color: hexaColor('#BEA07D'),
                  letterSpacing: 3,
                  fontSize: vw * 0.03,
                ),
              ),
              trailing: Container(
                child: SvgPicture.asset(
                  'assets/icons/next.svg',
                  width: vw * 0.07,
                ),
              ),
            ),
          ),
          Container(
            height: vw * 0.39,
            child: Row(
              children: [
                _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem(),
                _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem(),
                _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceHolderOfFilaDeSubCategoriaDeTiendasItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        left: vw * 0.05,
        top: vw * 0.02,
        right: vw * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: vw * 0.25,
                  width: vw * 0.24,
                  decoration: BoxDecoration(
                    color: hexaColor('#303030'),
                    boxShadow: [
                      BoxShadow(
                        color: rgbColor(0, 0, 0, 0.2),
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(vw * 0.05),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: vw * 0.01),
            child: Text(
              '....',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: hexaColor('#8C8C8C'),
                fontSize: vw * 0.03,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                '4.5',
                style: TextStyle(color: hexaColor('#DDDDDD'), fontSize: 10),
              ),
              SizedBox(width: 3),
              SvgPicture.asset(
                'assets/icons/full-star.svg',
                height: 7,
              ),
            ],
          )
        ],
      ),
    );
  }
}
