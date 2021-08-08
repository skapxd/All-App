part of 'store_pref.dart';

class StoreLogoPref {
  final _pref = Pref();

  final _pathUrlLogo = 'UrlLogo';

  void setUrlLogo({String value = ''}) {
    value = value ?? '';
    _pref.setAnyData(
      path: this._pathUrlLogo,
      object: value,
    );
  }

  String getUrlLogo() {
    return _pref.getAnyData(path: this._pathUrlLogo);
  }
}
