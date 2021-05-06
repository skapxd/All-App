import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RowShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(15),
          width: 90,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: hexaColor('#BEA07D'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  'assets/ruburos/supermercado.svg',
                  height: 40,
                  width: 40,
                ),
              ),
              Text(
                'Nombre de comercio',
                style: TextStyle(
                  color: hexaColor('#8C8C8C'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
