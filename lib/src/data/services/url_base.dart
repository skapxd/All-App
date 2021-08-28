import '../shared/user_pref/user_pref.dart';

import 'package:dio/dio.dart';

abstract class UrlBase {
  //

  final Dio urlBase = Dio(
    BaseOptions(
      headers: {
        'Authorization': 'Bearer ${UserTokenPref().getToken()}',
      },
      // baseUrl: 'https://allapp.app',
      baseUrl: 'https://all-app.herokuapp.com',
      // baseUrl: 'http://192.168.221.1:3000',
    ),
  );
}
