part of 'stores_service.dart';

class GetAllStoreService extends UrlBase {
  Future<CacheStoreModel> fetch({
    @required AddressModel cityPath,
    @required String category,
    @required int limit,
  }) async {
    //

    Map<String, dynamic> data = {
      'city': cityPath.city,
      'country': cityPath.country,
      'department': cityPath.department,
      'limit': limit,
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
