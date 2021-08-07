part of 'store_pref.dart';

class StoreWhatsAppPref {
  final _pref = Pref();
  final _storeWhatsApp = 'StoreWhatsApp';
  void setWhatsApp({String value = ''}) {
    _pref.setAnyData(
      path: this._storeWhatsApp,
      object: value,
    );
  }

  String getWhatsApp() {
    return _pref.getAnyData(path: this._storeWhatsApp);
  }
}
