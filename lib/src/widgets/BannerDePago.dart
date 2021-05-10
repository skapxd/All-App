import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BannerDePago extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.of(context).size.width;
    final vh = MediaQuery.of(context).size.height;

    return Column(
      children: [
        ListTile(
          title: Text(
            'Proximos eventos'.toUpperCase(),
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
        Container(
          height: vw * 0.3,
          margin: EdgeInsets.symmetric(vertical: vw * 0.02),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: vw * 0.07),
                // margin: EdgeInsets.symmetric(horizontal: vw * 0.09),
                height: vw * 0.3,
                width: vw * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: hexaColor('#BEA07D'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
