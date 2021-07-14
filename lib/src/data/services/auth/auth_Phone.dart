import 'package:allapp/src/data/shared/pref.dart';
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

    phone = phone.replaceAll('+', '');

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

  Future verifyPhoneCode({
    @required String phone,
    @required String code,
    Function(String token) onSuccess,
    Function onError,
  }) async {
    //

    phone = phone.replaceAll('+', '');

    Response res;

    try {
      res = await urlBase.post(
        '/auth/verify-phone-code',
        data: {
          "smsCode": code,
          "phone": phone,
        },
      );
    } catch (e) {
      print('AuthPhoneForWhatsApp: verifyPhoneCode - error: $e');
    }

    final bool success = res.data['success'];
    final String token = res.data['token'];

    _pref.token = token;

    print(res.data);

    if (success && onSuccess != null) {
      onSuccess(token);
    }

    if (!success && onError != null) {
      onError();
    }

    return success;
  }
}
