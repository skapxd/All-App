part of 'store_pref.dart';

class StoreIconCategoryPref {
  final _pref = Pref();
  final _storeIconCategory = 'StoreIconCategory';
  void setIconCategory({String value = ''}) {
    _pref.setAnyData(
      path: this._storeIconCategory,
      object: value,
    );
  }

  String getIconCategory() {
    return _pref.getAnyData(path: this._storeIconCategory);
  }
}
