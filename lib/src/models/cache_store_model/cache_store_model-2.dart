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
        @required this.latLng,
        @required this.urlImage,
        @required this.telegram,
        @required this.nameStore,
        @required this.phoneCall,
        @required this.direccion,
        @required this.visibilidad,
        @required this.phoneWhatsApp,
    });

    final String latLng;
    final String urlImage;
    final String telegram;
    final String nameStore;
    final String phoneCall;
    final String direccion;
    final bool visibilidad;
    final String phoneWhatsApp;

    factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
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
