import 'package:allapp/src/models/address_model.dart';

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
    @required AddressModel addressModel,
    Function(String token) onSuccess,
    Function(dynamic error) onError,
  }) async {
    //

    Response res;

    try {
      res = await urlBase.post(
        '/auth/verify-phone-code',
        data: {
          "smsCode": code,
          "phone": phone,
          "country": addressModel.country,
          "department": addressModel.department,
          "city": addressModel.city,
        },
      );
    } catch (e) {
      print('AuthPhoneForWhatsApp: verifyPhoneCode - error: $e');
    }

    final bool success = res.data['success'];
    final String token = res.data['token'];

    if (success && onSuccess != null) {
      onSuccess(token);
      return;
    }

    if (!success && onError != null) {
      onError(res.data);
      return;
    }
  }
}
