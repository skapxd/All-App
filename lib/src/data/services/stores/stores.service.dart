import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared/pref.dart';
import '../../../models/address_model.dart';
import '../../../models/store_model.dart';
import 'package:meta/meta.dart';

import '../url_base.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomGeoLocation {
  final double lat;
  final double lng;

  CustomGeoLocation({
    @required this.lat,
    @required this.lng,
  });
}

class ContactStore {
  final String telegramStore;
  final String phonCallStore;
  final String whatsAppStore;

  ContactStore({this.telegramStore, this.phonCallStore, this.whatsAppStore});
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

    // En caso de que el cache sea valido

    return await _getAllStores(
      category: category,
      cityPath: cityPath,
      onFailed: onFailed,
      onSuccess: onSuccess,
    );
  }

  Future<CacheStoreModel> _getAllStores({
    @required AddressModel cityPath,
    @required String category,
    // @required Function() onProgress,
    @required Function({dynamic data}) onSuccess,
    @required Function({dynamic data}) onFailed,
  }) async {
    //
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
    Dio _dio = Dio();
    Options _cacheOptions = buildCacheOptions(Duration(days: 7));

    _dio.interceptors.add(_dioCacheManager.interceptor);

    final path =
        '__cache__${cityPath.country}/${cityPath.department}/${cityPath.city}/$category';

    Map<String, dynamic> data = {
      'city': cityPath.city,
      'country': cityPath.country,
      'department': cityPath.department,
    };
    if (category != null) {
      data.addAll({'category': category});
    }

    dynamic res;
    Response resTemp;
    try {
      resTemp = await this.urlBase.get(
            '/api-v1/stores',
            queryParameters: data,
            options: _cacheOptions,
          );
      res = json.encode(resTemp.data);
    } catch (e) {
      print('error: $e');
      if (onFailed != null) {
        onFailed(data: e);
      }
    }

    if (onSuccess != null && resTemp.data['success']) {
      onSuccess(data: res);
    }

    if (onFailed != null && !resTemp.data['success']) {
      onFailed(data: res);
    }
    // CacheStoreModel.fromMap(resTemp.data);
    final cache = cacheStoreModelFromMap(res);

    return cache;
  }

  Future<void> createStore({
    String nameStore,
    String categoryStore,
    bool visibility,
    ContactStore contactStore,
    void Function() onProgress,
    void Function({dynamic data}) onSuccess,
    void Function({dynamic data}) onFailed,
  }) async {
    //

    Map<String, dynamic> data = {};

    final setData = () {
      if (nameStore != null) {
        data.addAll({'nameStore': nameStore});
      }

      if (categoryStore != null) {
        data.addAll({'category': categoryStore});
      }

      if (visibility != null) {
        data.addAll({'visibility': visibility});
      }

      print(visibility);

      if (contactStore.telegramStore != null) {
        data.addAll({'telegram': contactStore.telegramStore});
      }

      if (contactStore.phonCallStore != null) {
        data.addAll({'phoneCall': contactStore.phonCallStore});
      }

      if (contactStore.whatsAppStore != null) {
        data.addAll({'whatsApp': contactStore.whatsAppStore});
      }
    };

    setData();

    if (onProgress != null) {
      onProgress();
    }

    dynamic res;

    try {
      //

      res = (await this.urlBase.post('/api-v1/stores', data: data)).data;
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

  Future<void> uploadLogo({
    @required String file,
    @required Function(String urlLogo) onSuccess,
    @required Function(dynamic error) onFailed,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file,
        filename: 'logo.${file.split('.').last}',
        // filename: file.split('/').last,
      )
      // 'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt')
    });

    Response res;
    try {
      res = await this.urlBase.post('/api-v1/stores/upload', data: formData);

      if (onSuccess != null && res.data['success']) {
        onSuccess(res.data['urlImage']);
      }
    } catch (e) {
      if (onFailed != null && !res.data['success']) {
        onFailed(e);
      }
      print('StoresService - catch: $e');
    }
  }

  Future<void> setLocationInDB({
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
