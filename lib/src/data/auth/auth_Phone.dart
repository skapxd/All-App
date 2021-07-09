import 'package:allapp/src/data/auth/url_base.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@Deprecated('Not use fire auth, is very low, use AuthPhoneForWhatsApp')
class AuthPhone {
  String token = '';
  Future<void> sendMsg({
    @required String phone,
    ValueChanged<String> onSuccess,
    ValueChanged<String> onGetToken,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential).then((value) {
        onSuccess(token);
      });
    };

    PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }

      print('AuthPhone: Failed');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('AuthPhone: Code Resent');
      token = verificationId;
      onGetToken(token);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      token = verificationId;
      onGetToken(token);
    };

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 5),
      );
    } catch (e) {
      print("AuthPhone: Failed to Verify Phone Number: $e");
    }
  }

  // Sign In sms
  enterMsg({
    String smsCode,
    VoidCallback onSuccess,
    String token,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      print('AuthPhone Init Try sms');
      print('AuthPhone $smsCode');
      print('AuthPhone $token');

      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: token,
        smsCode: smsCode,
      );

      _auth.signInWithCredential(credential).then((value) {
        onSuccess();
      });
    } catch (e) {
      print('AuthPhone: $e');
      print("AuthPhone: Failed to sign in");
    }
  }
}

class AuthPhoneForWhatsApp extends UrlBase {
  Future verifyPhone({
    @required String phone,
    Function onSuccess,
    Function onError,
  }) async {
    //

    phone = phone.replaceAll('+', '');

    Response res;

    try {
      res = await url.post(
        '/api-v1/users/send-whatsapp-code',
        data: {"phone": phone},
      );
    } catch (e) {
      print('AuthPhoneForWhatsApp: verifyPhone - error: $e');
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

  Future verifyCode({
    @required String phone,
    @required String code,
    Function(String token) onSuccess,
    Function onError,
  }) async {
    //

    phone = phone.replaceAll('+', '');

    Response res;

    try {
      res = await url.post(
        '/api-v1/users/send-code-backend',
        data: {
          "smsCode": code,
          "phone": phone,
        },
      );
    } catch (e) {
      print('AuthPhoneForWhatsApp: verifyCode - error: $e');
    }

    final bool success = res.data['success'];
    final String token = res.data['token'];

    if (success && onSuccess != null) {
      onSuccess(token);
    }

    if (!success && onError != null) {
      onError();
    }

    return success;
  }
}
