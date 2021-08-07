part of 'user_pref.dart';

class UserPhonePref {
  final _pref = Pref();
  final _userPhone = 'UserPhone';
  void setPhone({String phone = ''}) {
    _pref.setAnyData(
      path: this._userPhone,
      object: phone,
    );
  }

  String getPhone() {
    return _pref.getAnyData(path: this._userPhone);
  }
}
