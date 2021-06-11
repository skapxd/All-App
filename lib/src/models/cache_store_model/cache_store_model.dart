import 'package:meta/meta.dart';
import 'dart:convert';

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
    @required this.id,
    @required this.latLng,
    @required this.urlImage,
    @required this.telegram,
    @required this.nameStore,
    @required this.phoneCall,
    @required this.direccion,
    @required this.visibilidad,
    @required this.phoneWhatsApp,
  });

  final String id;
  final String latLng;
  final String urlImage;
  final String telegram;
  final String nameStore;
  final String phoneCall;
  final String direccion;
  final bool visibilidad;
  final String phoneWhatsApp;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        latLng: json["latLng"],
        urlImage: json["urlImage"],
        telegram: json["telegram"],
        nameStore: json["nameStore"],
        phoneCall: json["phoneCall"],
        direccion: json["direccion"],
        visibilidad: json["visibilidad"],
        phoneWhatsApp: json["phoneWhatsApp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latLng": latLng,
        "urlImage": urlImage,
        "telegram": telegram,
        "nameStore": nameStore,
        "phoneCall": phoneCall,
        "direccion": direccion,
        "visibilidad": visibilidad,
        "phoneWhatsApp": phoneWhatsApp,
      };
}

// https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq
// {
//     "expire": "123",
//     "path": "123",
//     "StoreModel": [
//             {
//             "id": "string",
//             "latLng" : "string",
//             "urlImage" : "string",
//             "telegram" : "string",
//             "nameStore" : "string",
//             "phoneCall" : "string",
//             "direccion" : "string",
//             "visibilidad" : true,
//             "phoneWhatsApp" : "string"
//         }
//     ]
// }
