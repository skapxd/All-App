part of 'store_pref.dart';

class StoreTelegramPref {
  final _pref = Pref();
  final _storeTelegram = 'StoreTelegram';
  void setTelegram({String value = ''}) {
    _pref.setAnyData(
      path: this._storeTelegram,
      object: value,
    );
  }

  String getTelegram() {
    return _pref.getAnyData(path: this._storeTelegram);
  }
}
