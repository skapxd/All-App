part of 'stores_service.dart';

class SendListProductsCategoryService extends UrlBase {
  void send({
    @required List<String> productsCategories,
  }) {
    try {
      this.urlBase.post('/api-v1/stores/list-product-categories', data: {
        "list": productsCategories,
      });
    } catch (e) {
      print('Error Send List Product Category');
    }
  }
}
