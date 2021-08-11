part of 'product_store_pref.dart';

class ListProductStorePrefPref {
  final _pref = Pref();
  final _pathListProductStorePref = 'ListProductStorePref';
  void set({ListProduct value}) {
    final data = listProductToMap(value);

    _pref.setAnyData(
      path: this._pathListProductStorePref,
      object: data,
    );
  }

  ListProduct get() {
    final data = _pref.getAnyData(path: this._pathListProductStorePref);

    if (data != null) {
      return listProductFromMap(data);
    } else {
      return ListProduct(success: true, listProduct: []);
    }
  }
}
