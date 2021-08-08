part of 'store_pref.dart';

class StoreIfVisiblePref {
  final _pref = Pref();
  final _storeIfVisible = 'StoreIfVisible';
  void setIfVisible({bool value = true}) {
    value = value ?? true;
    _pref.setAnyData(
      path: this._storeIfVisible,
      object: value.toString(),
    );
  }

  bool getIfVisible() {
    return (_pref.getAnyData(path: this._storeIfVisible) ?? 'false') == 'true';
  }
}
