// To parse this JSON data, do
//
//     final cacheStoreModel = cacheStoreModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

CacheStoreModel cacheStoreModelFromJson(String str) =>
    CacheStoreModel.fromJson(json.decode(str));

String cacheStoreModelToJson(CacheStoreModel data) =>
    json.encode(data.toJson());

class CacheStoreModel {
  CacheStoreModel({
    @required this.expire,
    @required this.path,
    @required this.storeModel,
  });

  final String expire;
  final String path;
  final List<StoreModel> storeModel;

  factory CacheStoreModel.fromJson(Map<String, dynamic> json) =>
      CacheStoreModel(
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
    @required this.direccion,
    @required this.latLng,
    @required this.nameStore,
    @required this.phoneCall,
    @required this.phoneWhatsApp,
    @required this.telegram,
    @required this.urlImage,
    @required this.visibilidad,
  });

  final String direccion;
  final String latLng;
  final String nameStore;
  final String phoneCall;
  final String phoneWhatsApp;
  final String telegram;
  final String urlImage;
  final bool visibilidad;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        direccion: json["direccion"],
        latLng: json["latLng"],
        nameStore: json["nameStore"],
        phoneCall: json["phoneCall"],
        phoneWhatsApp: json["phoneWhatsApp"],
        telegram: json["telegram"],
        urlImage: json["urlImage"],
        visibilidad: json["visibilidad"],
      );

  Map<String, dynamic> toJson() => {
        "direccion": direccion,
        "latLng": latLng,
        "nameStore": nameStore,
        "phoneCall": phoneCall,
        "phoneWhatsApp": phoneWhatsApp,
        "telegram": telegram,
        "urlImage": urlImage,
        "visibilidad": visibilidad,
      };
}

// https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq
// {
//     "expire": "123",
//     "path": "123",
//     "StoreModel": [
//             {
//             "latLng" : "123",
//             "urlImage" : "123",
//             "telegram" : "123",
//             "nameStore" : "123",
//             "phoneCall" : "123",
//             "direccion" : "123",
//             "visibilidad" : true,
//             "phoneWhatsApp" : "123",
//         }
//     ]
// }

// direccion
// latLng
// nameStore
// phoneCall
// phoneWhatsApp
// telegram
// urlImage
// visibilidad
