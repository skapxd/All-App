import 'package:dio/dio.dart';

abstract class UrlBase {
  final Dio urlBase = Dio(
    BaseOptions(
      baseUrl: 'https://allapp.app',
      // baseUrl: 'http://192.168.221.1:3000',
      // baseUrl: 'https://all-app-dot-multi-entregas-je.uc.r.appspot.com',
    ),
  );
}
