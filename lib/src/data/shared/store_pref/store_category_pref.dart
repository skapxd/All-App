part of 'store_pref.dart';

class StoreCategoryPref {
  final _pref = Pref();
  final _storeCategory = 'StoreCategory';
  void setCategory({String category = ''}) {
    _pref.setAnyData(
      path: this._storeCategory,
      object: category,
    );
  }

  String getCategory() {
    return _pref.getAnyData(path: this._storeCategory);
  }
}
