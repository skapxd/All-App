part of './stores_service.dart';

class StoreGetAllService extends UrlBase {
  Future<CacheStoreModel> getStore({
    @required AddressModel cityPath,
    @required String category,
  }) async {
    //

    Map<String, dynamic> data = {
      'city': cityPath.city,
      'country': cityPath.country,
      'department': cityPath.department,
    };

    if (category != null) {
      data.addAll({'category': category});
    }

    final res = await this.urlBase.get(
          '/api-v1/stores',
          queryParameters: data,
        );
    return CacheStoreModel.fromMap(res.data);
  }
}
