import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/01_wellcome/01_wellcome.dart';
import 'package:meta/meta.dart';
// class ApiPref {
//   final Pref _pref = Pref();

//   CacheStoreModel getStoreCache({String path}) {
//     final cache = cacheStoreModelFromJson(_pref.cacheStore);
//     return cache;
//   }

//   void setStoreCache({CacheStoreModel cacheStoreModel}) {
//     final cache = cacheStoreModelToJson(cacheStoreModel);
//     _pref.cacheStore = cache;
//   }
// }

// @Deprecated('ApiPref')
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

  /// Get any data
  String getAnyData({@required String path}) {
    return _pref.get(path);
  }

  /// Set any data
  Future<bool> setAnyData({
    @required String path,
    @required String object,
  }) async {
    return await _pref.setString(path, object);
  }

  /// Remove any data
  void deleteAnyData({@required String path}) async {
    await _pref.remove(path);
  }

  // GET & SET -> Ultima pagina
  String get lastPage {
    return _pref.getString('lastPage') ?? WelcomePage.pathName;
  }

  set lastPage(String value) => _pref.setString('lastPage', value);

  ////////////////////////////////////////////////////////////////////
  /// Pref de tienda
  ////////////////////////////////////////////////////////////////////

  // GET & SET -> Path de icon en la nube
  // String get iconCludPath => _pref.getString('iconCludPath') ?? '';

  // set iconCludPath(String value) => _pref.setString('iconCludPath', value);

  // GET & SET -> Path de icon en lcoal
  // String get iconLocalPath => _pref.getString('iconLocalPath');

  // set iconLocalPath(String value) => _pref.setString('iconLocalPath', value);

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

  // GET & SET -> Nombre de tipo tienda
  String get categoriaDeTienda => _pref.getString('nombreTipoDeTienda');

  set categoriaDeTienda(String value) =>
      _pref.setString('nombreTipoDeTienda', value);

  // GET & SET -> Nombre de tienda
  String get pathIconTipoDeTienda => _pref.getString('pathTipoDeTienda');

  set pathIconTipoDeTienda(String value) =>
      _pref.setString('pathTipoDeTienda', value);

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
