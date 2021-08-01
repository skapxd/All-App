part of './store_pref.dart';

class StoreDescriptionPref {
  final _pref = Pref();
  final _storeDescription = 'StoreDescription';
  void setDescription({String value}) {
    _pref.setAnyData(
      path: this._storeDescription,
      object: value,
    );
  }

  String getDescription() {
    return _pref.getAnyData(path: this._storeDescription) ?? '';
  }
}
