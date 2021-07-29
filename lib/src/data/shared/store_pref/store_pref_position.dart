part of './store_pref.dart';

class StorePrefPosition {
  final _pref = Pref();

  final pathLatLngList = 'LatLngList';

  void setLatLngList({List<LatLng> listOfLatLng}) async {
    if (listOfLatLng != null) {
      final dataToMap = listOfLatLng.map((e) {
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

  List<StoreModel.LatLng> getLatLngList() {
    final getDataAsString = _pref.getAnyData(path: pathLatLngList);
    if (getDataAsString == null) {
      return List<StoreModel.LatLng>.empty();
    }
    final List<dynamic> getDataAsList =
        // final List<Map<String, double>> getDataAsList =
        json.decode(getDataAsString);
    final List<StoreModel.LatLng> listLatLng = getDataAsList.map((e) {
      return StoreModel.LatLng(
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
