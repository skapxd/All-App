part of 'user_pref.dart';

class UserNamePref {
  final _pref = Pref();
  final _userName = 'UserName';
  void setName({String name}) {
    name = name ?? 'Nombre';
    _pref.setAnyData(
      path: this._userName,
      object: name,
    );
  }

  String getName() {
    return _pref.getAnyData(path: this._userName) ?? 'Nombre';
  }
}
