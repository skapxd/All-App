import 'package:allapp/src/data/services/url_base.dart';
import 'package:allapp/src/models/address_model.dart';
import 'package:meta/meta.dart';

class UtilsServices extends UrlBase {
  Future<AddressModel> getAddressModel({
    @required String lat,
    @required String lng,
  }) async {
    final res = await urlBase.get('/api-v1/geo-coding', queryParameters: {
      'lng': lng,
      'lat': lat,
    });

    return AddressModel(
      city: res.data['city'],
      country: res.data['country'],
      department: res.data['department'],
    );
  }
}
