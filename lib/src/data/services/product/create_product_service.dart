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
    final Map<String, dynamic> data = {};
    //   "availability": availability,
    //   "name": name,
    //   "price": price,
    //   "quantity": quantity,
    //   "category": category,
    //   "urlImageProductStore": urlImageProductStore,
    // };

    if (id != null) {
      data.addAll({"id": id});
    }

    if (availability != null) {
      data.addAll({"availability": availability});
    }

    if (name != null) {
      data.addAll({"name": name});
    }

    if (price != null) {
      data.addAll({"price": price});
    }

    if (quantity != null) {
      data.addAll({"quantity": quantity});
    }

    if (category != null) {
      data.addAll({"category": category});
    }

    if (urlImageProductStore != null) {
      data.addAll({"urlImageProductStore": urlImageProductStore});
    }

    print(data);
    // print(res.data);

    Response res = await urlBase.post(
      '/api-v1/stores/product',
      data: data,
    );

    return ListProduct.fromMap(res.data);
  }
}
