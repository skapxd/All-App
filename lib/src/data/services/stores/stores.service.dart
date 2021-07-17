import '../../shared/pref.dart';
import '../../../models/address_model.dart';
import '../../../models/store_model.dart';
import 'package:meta/meta.dart';

import '../url_base.dart';

class CustomGeoLocation {
  final double lat;
  final double lng;

  CustomGeoLocation({
    @required this.lat,
    @required this.lng,
  });
}

class StoresService extends UrlBase {
  //

  final now = DateTime.now();

  final pref = Pref();

  //
  Future<CacheStoreModel> getCacheAllStores({
    @required AddressModel cityPath,
    @required String category,
    Function() onProgress,
    Function({dynamic data}) onSuccess,
    Function({dynamic data}) onFailed,
  }) async {
    //

    final path =
        '__cache__${cityPath.country}/${cityPath.department}/${cityPath.city}/$category';

    String cacheString = pref.getAnyData(path: path);

    CacheStoreModel cacheClass;

    // En caso de que el cache no exista
    if (cacheString == null) {
      print('Cache no existe ');
      cacheClass = await _getAllStores(
        cityPath: cityPath,
        category: category,
        onFailed: onFailed,
        onProgress: onProgress,
        onSuccess: onSuccess,
      );

      cacheString = getStringCacheStoreModel(cacheClass);

      pref.setAnyData(path: path, object: cacheString);

      return cacheClass;
    }

    cacheClass = getObjectCacheStoreModel(cacheString);

    final expire = DateTime.tryParse(cacheClass.expire);

    // En caso de que el cache halla expirado
    if (expire.isBefore(now)) {
      print('Cache expirado');
      cacheClass = await _getAllStores(
        cityPath: cityPath,
        category: category,
        onFailed: onFailed,
        onProgress: onProgress,
        onSuccess: onSuccess,
      );

      cacheString = getStringCacheStoreModel(cacheClass);

      pref.setAnyData(path: path, object: cacheString);

      return cacheClass;
    }

    // En caso de que el cache sea valido
    print('Cache valido');

    return cacheClass;
  }

  Future<CacheStoreModel> _getAllStores({
    @required AddressModel cityPath,
    @required String category,
    @required Function() onProgress,
    @required Function({dynamic data}) onSuccess,
    @required Function({dynamic data}) onFailed,
  }) async {
    //

    final path =
        '__cache__${cityPath.country}/${cityPath.department}/${cityPath.city}/$category';

    Map<String, dynamic> data = {
      'city': cityPath.city,
      'country': cityPath.country,
      'department': cityPath.department,
    };

    if (category != null) {
      data.addAll({'categoryStore': category});
    }

    dynamic res;

    if (onProgress != null) {
      onProgress();
    }

    // res = (await urlBase.get(
    //   '/api-v1/stores',
    //   queryParameters: data,
    // ))
    //     .data;
    try {
      res = (await urlBase.get(
        '/api-v1/stores',
        queryParameters: data,
      ))
          .data;
    } catch (e) {
      print('error: $e');
      if (onFailed != null) {
        onFailed(data: e);
      }
    }

    if (onSuccess != null && res['success']) {
      onSuccess(data: res);
    }

    if (onFailed != null && !res['success']) {
      onFailed(data: res);
    }

    print(res);

    final expire = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      (now.minute + 1),
    );

    final cache = CacheStoreModel.getObject(
      expire: expire.toIso8601String(),
      path: path,
      storeModel: res,
    );

    return cache;
  }

  Future<void> createStore({
    String urlImage,
    String nameStore,
    void Function() onProgress,
    void Function({dynamic data}) onSuccess,
    void Function({dynamic data}) onFailed,
    String addressStore,
    String telegramStore,
    String categoryStore,
    String phonCallStore,
    String whatsAppStore,
    @required String phoneIdStore,
    @required AddressModel addressModel,
    List<CustomGeoLocation> geolocationStore,
  }) async {
    //

    Map<String, dynamic> data = {};

    if (urlImage != null) {
      data.addAll({'urlImage': urlImage});
    }

    if (nameStore != null) {
      data.addAll({'nameStore': nameStore});
    }

    if (addressStore != null) {
      data.addAll({'addressStore': addressStore});
    }

    if (telegramStore != null) {
      data.addAll({'telegramStore': telegramStore});
    }

    if (categoryStore != null) {
      data.addAll({'categoryStore': categoryStore});
    }

    if (phonCallStore != null) {
      data.addAll({'phonCallStore': phonCallStore});
    }

    if (whatsAppStore != null) {
      data.addAll({'whatsAppStore': whatsAppStore});
    }

    if (addressModel != null) {
      data.addAll({'city': addressModel.city});
      data.addAll({'country': addressModel.country});
      data.addAll({'department': addressModel.department});
    }

    if (phoneIdStore != null) {
      data.addAll({'phoneIdStore': phoneIdStore});
    }

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

    print(data);

    dynamic res;

    try {
      //

      res = (await urlBase.post('/api-v1/stores', data: data)).data;
    } catch (e) {
      //

      if (onProgress != null) {
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
