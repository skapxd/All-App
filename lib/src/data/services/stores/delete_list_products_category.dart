part of 'stores_service.dart';

class DeleteListProductsCategoryService extends UrlBase {
  void send({
    @required List<String> productsCategories,
  }) {
    this.urlBase.delete('/api-v1/stores/list-product-categories', data: {
      "list": productsCategories,
    });
  }
}
