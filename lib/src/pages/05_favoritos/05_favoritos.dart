import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/utils.dart';

class FavoritosPage extends StatelessWidget {
  static final String pathName = '/FavoritosPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'FAVORITOS',
            style: TextStyle(
              color: hexaColor('#E6D29F'),
              letterSpacing: 5,
              height: 1.5,
              fontSize: 15,
            ),
          ),
          leading: InkWell(
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
        backgroundColor: hexaColor('#303030'),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              height: vw * 0.1,
              child: Row(
                children: [
                  Container(
                    height: vw * 0.1,
                    width: vw * 0.1,
                    color: Colors.white,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
