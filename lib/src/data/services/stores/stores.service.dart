import '../../shared/pref.dart';
import '../../../models/address_model.dart';
import '../../../models/store_model.dart';
import 'package:meta/meta.dart';

import '../url_base.dart';

class StoresService extends UrlBase {
  //

  final now = DateTime.now();

  final pref = Pref();

  //
  Future<CacheStoreModel> getCacheAllStores({
    @required AddressModel cityPath,
    @required String category,
  }) async {
    //

    final path =
        '__cache__${cityPath.country}/${cityPath.department}/${cityPath.city}/$category';

    String cacheString = pref.getAnyData(path: path);

    CacheStoreModel cacheClass;

    // En caso de que el cache no exista
    if (cacheString == null) {
      print('Cache no existe ');
      cacheClass = await _getAllStores(cityPath: cityPath, category: category);

      cacheString = getStringCacheStoreModel(cacheClass);

      pref.setAnyData(path: path, object: cacheString);

      return cacheClass;
    }

    cacheClass = getObjectCacheStoreModel(cacheString);

    final expire = DateTime.tryParse(cacheClass.expire);

    // En caso de que el cache halla expirado
    if (expire.isBefore(now)) {
      print('Cache expirado');
      cacheClass = await _getAllStores(cityPath: cityPath, category: category);

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
  }) async {
    //

    final path =
        '__cache__${cityPath.country}/${cityPath.department}/${cityPath.city}/$category';

    Map<String, dynamic> data = {
      'city': cityPath.city,
      'country': cityPath.country,
      'departament': cityPath.department,
    };

    if (category != null) {
      data.addAll({'category': category});
    }

    final res = await urlBase.get(
      '/api-v1/stores',
      queryParameters: data,
    );

    print(res.data);

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
      storeModel: res.data,
    );

    return cache;
  }
}
