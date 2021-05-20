import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/01_wellcome/01_wellcome.dart';

class Pref {
  static final Pref _instance = new Pref._internal();

  factory Pref() {
    return _instance;
  }

  Pref._internal();

  SharedPreferences _pref;

  initPref() async {
    this._pref = await SharedPreferences.getInstance();
  }

  ////////////////////////////////////////////////////////////////////
  /// Pref de app
  ////////////////////////////////////////////////////////////////////

  // GET & SET -> Ultima pagina
  String get lastPage => _pref.getString('lastPage') ?? WelcomePage.pathName;

  set lastPage(String value) => _pref.setString('lastPage', value);

  // GET & SET -> Prefijo de pais
  String get prefix => _pref.getString('prefix') ?? '+57';

  set prefix(String value) => _pref.setString('prefix', value);

  // GET & SET -> Numero de telefono
  String get phone => _pref.getString('phone') ?? '';

  set phone(String value) => _pref.setString('phone', value);

  // GET & SET -> Nombre de usuario
  String get nombe => _pref.getString('nombe') ?? 'Nombre';

  set nombe(String value) => _pref.setString('nombe', value);

  ////////////////////////////////////////////////////////////////////
  /// Pref de tienda
  ////////////////////////////////////////////////////////////////////

  // GET & SET -> Path de icon
  String get iconPath => _pref.getString('iconPath') ?? '';

  set iconPath(String value) => _pref.setString('iconPath', value);

  // GET & SET -> Habilitar edicion
  bool get ifHabilitarEdicion => _pref.getBool('ifHabilitarEdicion') ?? true;

  set ifHabilitarEdicion(bool value) =>
      _pref.setBool('ifHabilitarEdicion', value);

  // GET & SET -> Visibilidad de tienda
  bool get ifVisibilidadDeTienda =>
      _pref.getBool('ifVisibilidadDeTienda') ?? false;

  set ifVisibilidadDeTienda(bool value) =>
      _pref.setBool('ifVisibilidadDeTienda', value);

  // GET & SET -> Nombre de tienda
  String get nombreDeTienda => _pref.getString('nombreDeTienda') ?? '';

  set nombreDeTienda(String value) => _pref.setString('nombreDeTienda', value);

  // GET & SET -> Telefono de tienda
  String get telefotoDeTienda => _pref.getString('telefotoDeTienda') ?? '';

  set telefotoDeTienda(String value) =>
      _pref.setString('telefotoDeTienda', value);

  // GET & SET -> WhatsApp de tienda
  String get whatsAppDeTienda => _pref.getString('whatsAppDeTienda') ?? '';

  set whatsAppDeTienda(String value) =>
      _pref.setString('whatsAppDeTienda', value);

  // GET & SET -> Telegram de tienda
  String get telegramDeTienda => _pref.getString('telegramDeTienda') ?? '';

  set telegramDeTienda(String value) =>
      _pref.setString('telegramDeTienda', value);

  // GET & SET -> Direccion de tienda
  String get direccionDeTienda => _pref.getString('direccionDeTienda') ?? '';

  set direccionDeTienda(String value) =>
      _pref.setString('direccionDeTienda', value);

  // GET & SET -> Lat-Lan de tienda
  String get latLanDeTienda => _pref.getString('latLanDeTienda') ?? '';

  set latLanDeTienda(String value) => _pref.setString('latLanDeTienda', value);

  // GET & SET -> Ver informacion de la tienda
  bool get ifVerInfoDeTienda => _pref.getBool('ifVerInfoDeTienda') ?? true;

  set ifVerInfoDeTienda(bool value) =>
      _pref.setBool('ifVerInfoDeTienda', value);
}
