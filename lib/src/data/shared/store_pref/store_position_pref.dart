part of 'store_pref.dart';

class StorePositionPref {
  final _pref = Pref();

  final pathLatLngList = 'LatLngList';

  void setLatLngList({List<LatLng> value}) {
    value = value ?? [];
    if (value != null) {
      final dataToMap = value.map((e) {
        return {
          "lat": e.latitude,
          "lng": e.longitude,
        };
      }).toList();

      final dataToString = json.encode(dataToMap);
      print('StorePref: dataToString: $dataToString');

      _pref.setAnyData(
        path: pathLatLngList,
        object: dataToString,
      );
    }
  }

  List<LatLngStore> getLatLngList() {
    // List<LatLngStore> getLatLngList() {
    final getDataAsString = _pref.getAnyData(path: pathLatLngList);
    if (getDataAsString == null) {
      return List<LatLngStore>.empty();
    }
    final List<dynamic> getDataAsList =
        // final List<Map<String, double>> getDataAsList =
        json.decode(getDataAsString);
    final List<LatLngStore> listLatLng = getDataAsList.map((e) {
      return LatLngStore(
        lat: e['lat'],
        lng: e['lng'],
      );
    }).toList();
    print('StorePref: listLatLng: $listLatLng');

    return listLatLng;
  }

  void deleteLatLngList() {
    _pref.deleteAnyData(path: pathLatLngList);
  }
}
