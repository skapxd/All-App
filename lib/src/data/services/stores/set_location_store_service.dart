part of 'stores_service.dart';

class SetLocationStoreService extends UrlBase {
  Future<void> push({
    List<CustomGeoLocation> geolocationStore,
    void Function() onProgress,
    void Function({dynamic data}) onSuccess,
    void Function({dynamic data}) onFailed,
  }) async {
    Map<String, dynamic> data = {};

    List<Map<String, double>> geolocation = [];

    if (geolocationStore != null) {
      //

      geolocation = geolocationStore.map((e) {
        final Map<String, double> i = {
          'lat': e.lat,
          'lng': e.lng,
        };

        return i;
      }).toList();

      data.addAll({'latLng': geolocation});
    }

    if (onProgress != null) {
      onProgress();
    }

    dynamic res;

    try {
      //

      res = (await this.urlBase.post('/api-v1/stores/set-location', data: data))
          .data;
    } catch (e) {
      //

      if (onFailed != null) {
        onFailed();
      }
    }

    if (res['success'] && onSuccess != null) {
      onSuccess(data: res);
    } else if (!res['success'] && onFailed != null) {
      onFailed(data: res);
    }
  }
}
