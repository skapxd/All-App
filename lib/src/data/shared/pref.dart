import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/01_wellcome/01_wellcome.dart';
import 'package:meta/meta.dart';

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
}
