part of 'product_store_pref.dart';

// class CategoryProductStore {
//   final String name;

//   CategoryProductStore(this.name);
// }

class ListCategoryProductStorePref {
  final _pref = Pref();
  final _pathListCategoryProductStore = 'ListCategoryProductStore';
  void set({Set<String> value}) {
    //

    final setToJson = json.encode(value);

    _pref.setAnyData(
      path: this._pathListCategoryProductStore,
      object: setToJson,
    );
  }

  void add({String value}) {
    final listOfClass = get();

    listOfClass.add(value);

    set(value: listOfClass);
  }

  void delete() {
    this._pref.deleteAnyData(path: this._pathListCategoryProductStore);
  }

  Set<String> get() {
    //

    final mapAsJson =
        _pref.getAnyData(path: this._pathListCategoryProductStore) ?? '[]';

    final Set jsonToSet = json.decode(mapAsJson);

    return jsonToSet ?? Set<String>.from([]);
  }
}
