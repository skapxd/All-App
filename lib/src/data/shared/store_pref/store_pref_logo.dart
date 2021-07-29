part of './store_pref.dart';

class StorePrefLogo {
  final _pref = Pref();

  final pathUrlLogo = 'UrlLogo';

  void setUrlLogo(String urlLogo) {
    _pref.setAnyData(
      path: this.pathUrlLogo,
      object: urlLogo,
    );
  }

  String getUrlLogo() {
    return _pref.getAnyData(path: this.pathUrlLogo);
  }
}
