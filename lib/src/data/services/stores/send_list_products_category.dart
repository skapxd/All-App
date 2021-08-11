part of 'stores_service.dart';

class SendListProductsCategory extends UrlBase {
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
