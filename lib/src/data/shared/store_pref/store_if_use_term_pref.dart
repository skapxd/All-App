part of 'store_pref.dart';

class StoreIfUserTermPref {
  final _pref = Pref();
  final _useTerm = 'StoreUserTerm';
  void setUserTerm({bool value = false}) {
    value = value ?? false;
    _pref.setAnyData(
      path: this._useTerm,
      object: value.toString(),
    );
  }

  bool getUserTerm() {
    return (_pref.getAnyData(path: this._useTerm) ?? 'false') == 'true';
  }
}
