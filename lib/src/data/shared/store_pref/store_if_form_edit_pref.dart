part of 'store_pref.dart';

class StoreIfFormEditPref {
  final _pref = Pref();
  final _storeIfFormEdit = 'StoreIfFormEdit';
  void setIfFormEdit({bool value}) {
    value = value ?? true;
    _pref.setAnyData(
      path: this._storeIfFormEdit,
      object: value.toString(),
    );
  }

  bool getIfFormEdit() {
    return (_pref.getAnyData(path: this._storeIfFormEdit) ?? 'true') == "true";
  }
}
