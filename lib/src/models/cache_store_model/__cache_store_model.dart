// To parse this JSON data, do
//
//     final cacheStoreModel = cacheStoreModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CacheStoreModelDeprecated cacheStoreModelFromJson(String str) =>
    CacheStoreModelDeprecated.fromJson(json.decode(str));

String cacheStoreModelToJson(CacheStoreModelDeprecated data) =>
    json.encode(data.toJson());

class CacheStoreModelDeprecated {
  CacheStoreModelDeprecated({
    @required this.expire,
    @required this.path,
    @required this.storeModel,
  });

  final String expire;
  final String path;
  final List<StoreModel> storeModel;

  factory CacheStoreModelDeprecated.fromJson(Map<String, dynamic> json) =>
      CacheStoreModelDeprecated(
        expire: json["expire"],
        path: json["path"],
        storeModel: List<StoreModel>.from(
            json["StoreModel"].map((x) => StoreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expire": expire,
        "path": path,
        "StoreModel": List<dynamic>.from(storeModel.map((x) => x.toJson())),
      };
}

class StoreModel {
  StoreModel({
    @required this.id,
    @required this.urlImage,
    @required this.telegram,
    @required this.nameStore,
    @required this.phoneCall,
    @required this.direccion,
    @required this.visibilidad,
    @required this.phoneWhatsApp,
    @required this.latLng,
  });

  final String id;
  final String urlImage;
  final String telegram;
  final String nameStore;
  final String phoneCall;
  final String direccion;
  final bool visibilidad;
  final String phoneWhatsApp;
  final List<LatLng> latLng;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        urlImage: json["urlImage"],
        telegram: json["telegram"],
        nameStore: json["nameStore"],
        phoneCall: json["phoneCall"],
        direccion: json["direccion"],
        visibilidad: json["visibilidad"],
        phoneWhatsApp: json["phoneWhatsApp"],
        latLng:
            List<LatLng>.from(json["latLng"].map((x) => LatLng.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "urlImage": urlImage,
        "telegram": telegram,
        "nameStore": nameStore,
        "phoneCall": phoneCall,
        "direccion": direccion,
        "visibilidad": visibilidad,
        "phoneWhatsApp": phoneWhatsApp,
        "latLng": List<dynamic>.from(latLng.map((x) => x.toJson())),
      };
}

class LatLng {
  LatLng({
    @required this.lat,
    @required this.lng,
  });

  final double lat;
  final double lng;

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

// // https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq
// {
//     "expire": "123",
//     "path": "123",
//     "StoreModel": [
//             {
//             "id": "string",
//             "urlImage" : "string",
//             "telegram" : "string",
//             "nameStore" : "string",
//             "phoneCall" : "string",
//             "direccion" : "string",
//             "visibilidad" : true,
//             "phoneWhatsApp" : "string"
//             ,"latLng" : [
//                 {
//                     "lat": 123,
//                     "lng": 123
//                 }
//             ]
//         }
//     ]
// }
