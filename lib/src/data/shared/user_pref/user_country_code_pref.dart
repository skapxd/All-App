part of 'user_pref.dart';

class UserCountryCodePref {
  final _pref = Pref();
  final _userCountryCode = 'UserCountryCode';
  void setCountryCode({String countryCode = ''}) {
    _pref.setAnyData(
      path: this._userCountryCode,
      object: countryCode,
    );
  }

  String getCountryCode() {
    return _pref.getAnyData(path: this._userCountryCode);
  }
}
