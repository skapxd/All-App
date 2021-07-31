part of 'user_pref.dart';

class UserTokenPref {
  final _pref = Pref();
  final _userToken = 'UserToken';
  void setToken({String token}) {
    _pref.setAnyData(
      path: this._userToken,
      object: token,
    );
  }

  String getToken() {
    return _pref.getAnyData(path: this._userToken);
  }
}
