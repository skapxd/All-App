import 'package:allapp/src/pages/01_wellcome/01_wellcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // GET & SET
  String get lastPage => _pref.getString('lastPage') ?? WelcomePage.pathName;

  set lastPage(String value) => _pref.setString('lastPage', value);

  // GET & SET
  String get phone => _pref.getString('phone') ?? '';

  set phone(String value) => _pref.setString('phone', value);

  //
}