import 'package:allapp/src/data/services/url_base.dart';
import 'package:allapp/src/models/address_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class UtilsServices extends UrlBase {
  Future getAddressModel({
    @required String lat,
    @required String lng,
    Function(String error) onError,
    Function(AddressModel data) onSuccess,
  }) async {
    Response res;

    try {
      res = await urlBase.get(
        '/api-v1/geo-coding',
        queryParameters: {
          'lng': lng,
          'lat': lat,
        },
      );
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
    }

    if (onError != null && !res.data['success']) {
      onError(res.data['error']);
    }
    final address = AddressModel(
      city: res.data['location']['city'],
      country: res.data['location']['country'],
      department: res.data['location']['department'],
    );

    if (onSuccess != null) {
      onSuccess(address);
    }
  }
}
