import 'package:allapp/src/models/address_model.dart';
import 'package:allapp/src/models/user_login_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../url_base.dart';

class AuthPhone extends UrlBase {
  //

  final _pref = Pref();

  Future createPhoneCode({
    @required String phone,
    Function onSuccess,
    Function onError,
  }) async {
    //

    Response res;

    try {
      res = await urlBase.post(
        '/auth/create-phone-code',
        data: {"phone": phone},
      );
    } catch (e) {
      print('AuthPhoneForWhatsApp: createPhoneCode - error: $e');
    }

    final bool success = res.data['success'];

    if (success && onSuccess != null) {
      onSuccess();
    }

    if (!success && onError != null) {
      onError();
    }

    return success;
  }

  Future<void> verifyPhoneCode({
    @required String phone,
    @required String code,
    @required LatLng latLng,
    Function(LoginModel loginModel) onSuccess,
    Function(dynamic error) onError,
  }) async {
    //

    Response res;

    print(latLng);

    try {
      res = await urlBase.post(
        '/auth/verify-phone-code',
        data: {
          "smsCode": code,
          "phone": phone,
          "latLng": {
            "lat": latLng.latitude,
            "lng": latLng.longitude,
          }
        },
      );
    } catch (e) {
      print('AuthPhoneForWhatsApp: verifyPhoneCode - error: $e');
      onError(e);
    }

    final login = LoginModel.fromJson(res.data);

    if (login.success && onSuccess != null) {
      onSuccess(login);
      return;
    }

    if (!login.success && onError != null) {
      onError(res.data);
      return;
    }
  }
}
