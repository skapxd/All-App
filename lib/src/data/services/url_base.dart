import '../shared/pref.dart';
import 'package:dio/dio.dart';

abstract class UrlBase {
  //

  final Dio urlBase = Dio(
    BaseOptions(
      headers: {
        'Authorization': 'Bearer ${Pref().token}',
      },
      // baseUrl: 'https://allapp.app',
      baseUrl: 'http://192.168.221.1:3000',
    ),
  );
}
