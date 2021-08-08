part of 'product_store_pref.dart';

class ListCategoryProductStorePref {
  final _pref = Pref();
  final _pathListCategoryProductStore = 'ListCategoryProductStore';
  void set({List<String> value}) {
    //

    final listToJson = json.encode(value);

    _pref.setAnyData(
      path: this._pathListCategoryProductStore,
      object: listToJson,
    );
  }

  void add({String value}) {
    final listOfString = get();

    listOfString.add(value);

    set(value: listOfString);
  }

  void deleteAll() {
    this._pref.deleteAnyData(path: this._pathListCategoryProductStore);
  }

  void deleteGroup({List<String> values}) {
    List<String> listOfCategories = get();

    print('ListCategoryProductStorePref delete group $listOfCategories');

    values.forEach((element) {
      listOfCategories.remove(element);
    });

    set(value: listOfCategories);
  }

  List<String> get() {
    //

    final mapAsJson =
        _pref.getAnyData(path: this._pathListCategoryProductStore);

    List jsonToList;

    try {
      jsonToList = json.decode(mapAsJson);
    } catch (e) {
      jsonToList = List<String>.from([]);
    }

    final listToSet = Set<String>.from(jsonToList.cast<String>());

    return listToSet.toList();
  }
}
