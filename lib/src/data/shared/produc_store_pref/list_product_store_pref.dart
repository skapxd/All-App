part of 'product_store_pref.dart';

class ListProductStorePref {
  final _pref = Pref();
  final _pathListProductStorePref = 'ListProductStorePref';
  void set({ListProduct value}) {
    final data = listProductToMap(value);

    _pref.setAnyData(
      path: this._pathListProductStorePref,
      object: data,
    );
  }

  void delete({List<ListProductElement> values}) {
    ListProduct listOfCategories = get();

    values.forEach((element) {
      listOfCategories.listProduct.remove(element);
    });

    set(value: listOfCategories);
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
