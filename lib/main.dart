import 'package:allapp/src/data/shared/pref.dart';
import 'package:allapp/src/pages/01_wellcome/01_wellcome.dart';
import 'package:allapp/src/pages/02_03_Phone/02_Enter_Phone.dart';
import 'package:allapp/src/pages/02_03_Phone/03_Enter_Code.dart';
import 'package:allapp/src/pages/02_03_Phone/bloc/phone_bloc.dart';
import 'package:allapp/src/pages/04_home/04_Home.dart';
import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/BloqueDePago/PageImage.dart';
import 'package:allapp/src/widgets/SliverPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/widgets/Menu/bloc/menu_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  final pref = Pref();
  await pref.initPref();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => new PhoneBloc()),
        BlocProvider(create: (_) => new MenuBloc()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Color(0x00000000),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xff232323),
        ),
        sized: false,
        child: MaterialApp(
          color: Color(0xffffffff),
          debugShowCheckedModeBanner: false,
          title: 'AllApp',
          theme: ThemeData(
            scrollbarTheme: ScrollbarThemeData(),
            fontFamily: 'Montserrat',
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: hexaColor('#FFFFFF'),
              cursorColor: hexaColor('#FFFFFF'),
              selectionHandleColor: hexaColor('#FFFFFF'),
            ),
          ),
          initialRoute: Pref().lastPage,
          // initialRoute: SliverPage.pathName,
          routes: {
            WelcomePage.pathName: (_) => WelcomePage(),
            EnterPhone.pathName: (_) => EnterPhone(),
            EnterCode.pathName: (_) => EnterCode(),
            Home.pathName: (_) => Home(),
            SliverPage.pathName: (_) => SliverPage(),
            PageImage.pathName: (_) => PageImage(),
          },
        ),
      ),
    );
  }
}

// flutter build appbundle --target-platform android-arm,android-arm64,android-x64
// Construir apk   flutter build apk --release

// Comando para cambiar el icono
// flutter pub run flutter_launcher_icons:main

// Para obtener el SHA-1 es nesesario tener Java JDK

// Obtener SHA-1 debug
// keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

// Obtener SHA-1 Produccion
// keytool -list -v -keystore "c:\path key" -alias "key-name"
// ejp: keytool -list -v -keystore "C:\key.jks" -alias "key"

// Obtener SHA-1 debug y Produccion
// Dentro de la carpeta android de la app ejecutar el siguiente codigo
// "./gradlew signingReport" solo si estas en la termina de VsCode
// o gradlew signingReport si estas en cualquier terminal
