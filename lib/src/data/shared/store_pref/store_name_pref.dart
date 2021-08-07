part of 'store_pref.dart';

class StoreNamePref {
  final _pref = Pref();
  final _storeName = 'StoreName';
  void setName({String value = ''}) {
    _pref.setAnyData(
      path: this._storeName,
      object: value,
    );
  }

  String getName() {
    return _pref.getAnyData(path: this._storeName) ?? '';
  }
}
