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
    @required this.listoOfStore,
  });

  final String expire;
  final String path;
  final List<ListoOfStore> listoOfStore;

  factory CacheStoreModel.fromJson(Map<String, dynamic> json) =>
      CacheStoreModel(
        expire: json["expire"],
        path: json["path"],
        listoOfStore: List<ListoOfStore>.from(
            json["listoOfStore"].map((x) => ListoOfStore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expire": expire,
        "path": path,
        "listoOfStore": List<dynamic>.from(listoOfStore.map((x) => x.toJson())),
      };
}

class ListoOfStore {
  ListoOfStore({
    @required this.direccion,
    @required this.lat,
    @required this.nameStore,
    @required this.phoneWhatsApp,
    @required this.telegram,
    @required this.urlImage,
    @required this.visibilidad,
    @required this.phoneCall,
  });

  final String direccion;
  final String lat;
  final String nameStore;
  final String phoneWhatsApp;
  final String telegram;
  final String urlImage;
  final bool visibilidad;
  final String phoneCall;

  factory ListoOfStore.fromJson(Map<String, dynamic> json) => ListoOfStore(
        direccion: json["direccion"],
        lat: json["lat"],
        nameStore: json["nameStore"],
        phoneWhatsApp: json["phoneWhatsApp"],
        telegram: json["telegram"],
        urlImage: json["urlImage"],
        visibilidad: json["visibilidad"],
        phoneCall: json["phoneCall"],
      );

  Map<String, dynamic> toJson() => {
        "direccion": direccion,
        "lat": lat,
        "nameStore": nameStore,
        "phoneWhatsApp": phoneWhatsApp,
        "telegram": telegram,
        "urlImage": urlImage,
        "visibilidad": visibilidad,
        "phoneCall": phoneCall,
      };
}

// https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq
// {
//     "expire": "123",
//     "path": "123",
//     "listoOfStore": [
//             {
//             "direccion" : "123",
//             "lat" : "123",
//             "nameStore" : "123",
//             "phoneWhatsApp" : "123",
//             "telegram" : "123",
//             "nameStore" : "123",
//             "urlImage" : "123",
//             "nameStore" : "123",
//             "visibilidad" : true,
//             "phoneCall" : "123"
//         }
//     ]
// }
