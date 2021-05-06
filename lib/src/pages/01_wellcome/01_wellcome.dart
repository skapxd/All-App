import 'package:allapp/src/pages/02_03_Phone/02_Enter_Phone.dart';
import 'package:allapp/src/widgets/BackgroundGradient.dart';
import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/CustomText.dart';
import 'package:allapp/src/widgets/OutLineButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();
  static final String pathName = '/WelcomePage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomBackgroundGradient(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: (vw * 0.47)),
              child: SvgPicture.asset(
                'assets/brand/logo.svg',
                width: vw * 0.6,
              ),
            ),
            CustomText(
              'Una opción simple, segura y confiable\n para que puedas comprar lo que quieras\n donde quieras y cuando quieras.',
              margin: EdgeInsets.only(top: vw * 0.4),
              // width: vw * 0.83,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: hexaColor('#8C8C8C'),
                fontSize: vw * 0.035,
                height: 1.3,
              ),
            ),
            CustomOutLineButton(
              text: 'CONTINUAR',
              onTap: () => Navigator.pushNamed(context, EnterPhone.pathName),
              margin: EdgeInsets.only(top: vw * 0.5),
            ),
          ],
        ),
      ),
    );
  }
}