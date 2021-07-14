import 'dart:convert';

CacheStoreModel getObjectCacheStoreModel(String str) =>
    CacheStoreModel.fromMap(json.decode(str));

String getStringCacheStoreModel(CacheStoreModel data) =>
    json.encode(data.toMap());

class CacheStoreModel {
  CacheStoreModel({
    this.expire,
    this.path,
    this.storeModel,
  });

  final String expire;
  final String path;
  final List<StoreModel> storeModel;

  factory CacheStoreModel.getObject({
    Map<String, dynamic> storeModel,
    String expire,
    String path,
  }) {
    return CacheStoreModel(
      expire: expire,
      path: path,
      storeModel: List<StoreModel>.from(
        storeModel["res"].map((x) => StoreModel.fromMap(x)),
      ),
    );
  }

  factory CacheStoreModel.fromMap(Map<String, dynamic> json) {
    return CacheStoreModel(
      expire: json["expire"],
      path: json["path"],
      storeModel: List<StoreModel>.from(
        json["res"].map((x) => StoreModel.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "expire": expire,
      "path": path,
      "res": List<dynamic>.from(
        storeModel.map((x) => x.toMap()),
      ),
    };
  }
}

class StoreModel {
  StoreModel({
    this.id,
    this.urlImage,
    this.telegram,
    this.nameStore,
    this.phoneCall,
    this.direccion,
    this.visibilidad,
    this.phoneWhatsApp,
    this.latLng,
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

  factory StoreModel.fromMap(Map<String, dynamic> json) {
    return StoreModel(
      id: json["id"],
      urlImage: json["urlImage"],
      telegram: json["telegram"],
      nameStore: json["nameStore"],
      phoneCall: json["phoneCall"],
      direccion: json["direccion"],
      visibilidad: json["visibilidad"],
      phoneWhatsApp: json["phoneWhatsApp"],
      latLng:
          List<LatLng>.from(json["latLng"].map((x) => LatLng.fromMap(x))) ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "urlImage": urlImage,
      "telegram": telegram,
      "nameStore": nameStore,
      "phoneCall": phoneCall,
      "direccion": direccion,
      "visibilidad": visibilidad,
      "phoneWhatsApp": phoneWhatsApp,
      "latLng": List<dynamic>.from(latLng.map((x) => x.toMap())),
    };
  }
}

class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  final double lat;
  final double lng;

  factory LatLng.fromMap(Map<String, dynamic> json) => LatLng(
        lat: (json["lat"] / 1),
        lng: (json["lng"] / 1),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}
