import 'src/pages/01_wellcome/01_permisos.dart';
import 'src/pages/07_ver_comercios/ver_comercio.dart';
import 'src/pages/07_ver_comercios/ver_galeria_fotos/ver_galeria_fotos.dart';
import 'src/pages/07_ver_comercios/ver_mapa_page/ver_mapa_page.dart';
import 'src/pages/07_ver_comercios/ver_page_image_comercio/ver_page_image_comercio.dart';
import 'src/widgets/page_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/data/bloc/mapa/mapa_bloc.dart';
import 'src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'src/data/shared/pref.dart';
import 'src/pages/01_wellcome/01_wellcome.dart';
import 'src/pages/02_03_Phone/02_Enter_Phone.dart';
import 'src/pages/02_03_Phone/03_Enter_Code.dart';
import 'src/pages/02_03_Phone/bloc/phone_bloc.dart';
import 'src/pages/04_home/04_Home.dart';
import 'src/pages/04_home/bloc/home_bloc.dart';
import 'src/pages/05_favoritos/05_favoritos.dart';
import 'src/pages/06_crear_comercio/06_crear_comercio.dart';
import 'src/pages/06_crear_comercio/add-photos-page/Image_Page.dart';
import 'src/pages/06_crear_comercio/add-photos-page/Photos_Page.dart';
import 'src/pages/06_crear_comercio/bloc/comercio_bloc.dart';
import 'src/pages/06_crear_comercio/crear-producto-page/bloc/crear_producto_page_bloc.dart';
import 'src/pages/06_crear_comercio/crear-producto-page/crear_producto_page.dart';
import 'src/pages/06_crear_comercio/grupo_productos/grupo_productos.dart';
import 'src/pages/06_crear_comercio/mapa_page/mapa_page.dart';
import 'src/utils/utils.dart';
import 'src/widgets/Menu/bloc/menu_bloc.dart';
import 'src/widgets/PageImage.dart';
import 'src/widgets/SliverPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  final pref = Pref();
  await pref.initPref();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => new PhoneBloc()),
        BlocProvider(create: (_) => new MenuBloc()),
        BlocProvider(create: (_) => new ComercioBloc()),
        BlocProvider(create: (_) => new MiUbicacionBloc()),
        BlocProvider(create: (_) => new MapaBloc()),
        BlocProvider(create: (_) => new HomeBloc()),
        BlocProvider(create: (_) => new CrearProductoBloc()),
      ],
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
        title: 'AllApp',
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
        routes: {
          WelcomePage.pathName: (_) => WelcomePage(),
          PermisosPage.pathName: (_) => PermisosPage(),
          EnterPhone.pathName: (_) => EnterPhone(),
          EnterCode.pathName: (_) => EnterCode(),
          Home.pathName: (_) => Home(),
          SliverPage.pathName: (_) => SliverPage(),
          PageImage.pathName: (_) => PageImage(),
          PageImageComercio.pathName: (_) => PageImageComercio(),
          FavoritosPage.pathName: (_) => FavoritosPage(),
          ComercioPage.pathName: (_) => ComercioPage(),
          GrupoProductosPage.pathName: (_) => GrupoProductosPage(),
          PhotosPage.pathName: (_) => PhotosPage(),
          AddPageImage.pathName: (_) => AddPageImage(),
          ComercioMapaPage.pathName: (_) => ComercioMapaPage(),
          CrearProductoPage.pathName: (_) => CrearProductoPage(),
          VerComercios.pathName: (_) => VerComercios(),
          VerPageImageComercio.pathName: (_) => VerPageImageComercio(),
          VerGaleriaFotos.pathName: (_) => VerGaleriaFotos(),
          VerMapaPage.pathName: (_) => VerMapaPage(),
        },
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
