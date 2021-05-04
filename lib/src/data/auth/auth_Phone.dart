import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
