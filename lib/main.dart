import 'src/provider.dart';
import 'src/router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'src/data/shared/pref.dart';
import 'src/pages/01_wellcome/01_wellcome.dart';
import 'src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  final pref = Pref();
  await pref.initPref();

  runApp(
    MainProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MiUbicacionBloc miUbicacionBloc;

  @override
  void initState() {
    miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    super.initState();
  }

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
        color: Color(0xffffffff),
        debugShowCheckedModeBanner: false,
        title: 'All App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
          ),
          scrollbarTheme: ScrollbarThemeData(),
          fontFamily: 'Montserrat',
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: hexaColor('#FFFFFF'),
            cursorColor: hexaColor('#FFFFFF'),
            selectionHandleColor: hexaColor('#FFFFFF'),
          ),
        ),
        // initialRoute: Pref().lastPage,
        initialRoute: WelcomePage.pathName,
        routes: router,
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
