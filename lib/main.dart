import 'package:allapp/src/pages/01_wellcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0x00000000),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff232323),
      ),
      sized: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AllApp',
        initialRoute: WelcomePage.pathName,
        routes: {
          WelcomePage.pathName: (_) => WelcomePage(),
        },
      ),
    );
  }
}
