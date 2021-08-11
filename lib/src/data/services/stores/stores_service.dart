import 'package:dio/dio.dart';

import '../../shared/pref.dart';
import '../../../models/address_model.dart';
import '../../../models/store_model.dart';
import 'package:meta/meta.dart';

import '../url_base.dart';

part 'create_store_service.dart';
part 'get_all_store_service.dart';
part 'set_location_store_service.dart';
part 'send_list_products_category.dart';

class CustomGeoLocation {
  final double lat;
  final double lng;

  CustomGeoLocation({
    @required this.lat,
    @required this.lng,
  });
}

class ContactStore {
  final String telegram;
  final String phonCall;
  final String whatsApp;

  ContactStore({this.telegram, this.phonCall, this.whatsApp});
}
