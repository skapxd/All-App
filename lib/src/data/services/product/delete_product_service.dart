part of 'product_service.dart';

class DeleteGroupProducts extends UrlBase {
  Future<bool> send({@required List<ListProductElement> list}) async {
    final ids = list.map((e) {
      return e.id;
    }).toList();
    Map<String, List<String>> data = {
      'list': ids,
    };

    final res = await urlBase.delete(
      '/api-v1/stores/product',
      data: data,
    );

    return res.data['success'];
  }
}
