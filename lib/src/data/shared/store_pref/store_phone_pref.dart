part of 'store_pref.dart';

class StorePhonePref {
  final _pref = Pref();
  final _storePhone = 'StorePhone';
  void setPhone({String value = ''}) {
    _pref.setAnyData(
      path: this._storePhone,
      object: value,
    );
  }

  String getPhone() {
    return _pref.getAnyData(path: this._storePhone);
  }
}
