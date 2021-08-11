part of 'product_service.dart';

class CreateProductService extends UrlBase {
  Future<ListProduct> push({
    String id,
    @required bool availability,
    @required String name,
    @required String price,
    @required String quantity,
    @required String category,
    @required String urlImageProductStore,
  }) async {
    final Map<String, dynamic> data = {
      "availability": availability,
      "name": name,
      "price": price,
      "quantity": quantity,
      "category": category,
      "urlImageProductStore": urlImageProductStore,
    };

    if (id != null) {
      data.addAll({"id": id});
    }

    Response res = await urlBase.post(
      '/api-v1/stores/product',
      data: data,
    );

    print(data);
    print(res.data);

    return ListProduct.fromMap(res.data);
  }
}
