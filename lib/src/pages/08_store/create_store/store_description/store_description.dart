import '../../../../data/shared/store_pref/store_pref.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class DescriptionPage extends StatelessWidget {
  static final String pathName = '/DescriptionPage';

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    this._controller.text = StoreDescriptionPref().getDescription();
    this._controller.selection = TextSelection.fromPosition(
      TextPosition(offset: this._controller.text.length),
    );
    // View Width
    final double vw = MediaQuery.of(context).size.width;

    String description = '';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: rgbColor(0, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: hexaColor('#303030'),
      ),
      sized: true,
      child: Scaffold(
        backgroundColor: hexaColor('#303030'),
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          backgroundColor: hexaColor('#353535'),
          actions: [
            InkWell(
              highlightColor: rgbColor(0, 0, 0, 0),
              splashColor: rgbColor(0, 0, 0, 0),
              child: Container(
                height: vw * 0.07,
                width: vw * 0.07,
                child: SvgPicture.asset(
                  'assets/icons/check.svg',
                  height: vw * 0.07,
                ),
              ),
              onTap: () {
                print('DescriptionPage description: $description');
                StoreDescriptionPref().setDescription(value: description);
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: vw * 0.05,
            )
          ],
          title: Text(
            'DESCRIPCIÓN',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.5,
              fontSize: 15,
              color: hexaColor('#E6D29F'),
              letterSpacing: 5,
            ),
          ),
          leading: InkWell(
            borderRadius: BorderRadius.circular(vw),
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                'assets/icons/back-arrow.svg',
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: this._controller,
                onChanged: (value) => description = value,
                maxLines: null,
                style: TextStyle(
                  color: hexaColor('#f5f5f5'),
                  fontSize: 20,
                ),
                autofocus: true,
                decoration: InputDecoration.collapsed(
                  hintText: "Ingrese su descripción",
                  hintStyle: TextStyle(
                    color: hexaColor('#888888'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
