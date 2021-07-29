// To parse this JSON data, do
//
//     final cacheStoreModel = cacheStoreModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CacheStoreModel cacheStoreModelFromMap(String str) =>
    CacheStoreModel.fromMap(json.decode(str));

String cacheStoreModelToMap(CacheStoreModel data) => json.encode(data.toMap());

class CacheStoreModel {
  CacheStoreModel({
    @required this.storeModel,
  });

  final List<StoreModel> storeModel;

  factory CacheStoreModel.fromMap(Map<String, dynamic> json) => CacheStoreModel(
        storeModel: List<StoreModel>.from(
            json["allStores"]?.map((x) => StoreModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "allStores": List<dynamic>.from(storeModel?.map((x) => x.toMap())),
      };
}

class StoreModel {
  StoreModel({
    @required this.id,
    @required this.allStoreId,
    @required this.category,
    @required this.urlImage,
    @required this.nameStore,
    @required this.visibility,
    @required this.address,
    @required this.contact,
  });

  final String id;
  final String allStoreId;
  final String category;
  final String urlImage;
  final String nameStore;
  final bool visibility;
  final List<Address> address;
  final Contact contact;

  factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
        id: json["_id"],
        allStoreId: json["id"],
        category: json["category"],
        urlImage: json["urlImage"],
        nameStore: json["nameStore"],
        visibility: json["visibility"],
        address:
            List<Address>.from(json["address"]?.map((x) => Address.fromMap(x))),
        contact: Contact.fromMap(json["contact"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "id": allStoreId,
        "category": category,
        "urlImage": urlImage,
        "nameStore": nameStore,
        "visibility": visibility,
        "address": List<dynamic>.from(address?.map((x) => x.toMap())),
        "contact": contact.toMap(),
      };
}

class Address {
  Address({
    @required this.city,
    @required this.country,
    @required this.department,
    @required this.latLng,
  });

  final String city;
  final String country;
  final String department;
  final LatLng latLng;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        department: json["department"],
        latLng: LatLng.fromMap(json["latLng"]),
      );

  Map<String, dynamic> toMap() => {
        "city": city,
        "country": country,
        "department": department,
        "latLng": latLng.toMap(),
      };
}

class LatLng {
  LatLng({
    @required this.lat,
    @required this.lng,
  });

  final double lat;
  final double lng;

  factory LatLng.fromMap(Map<String, dynamic> json) => LatLng(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };

  @override
  String toString() {
    final temp = 'Instance of LatLng(Latitude $lat | Longitude $lng)';
    return temp;
  }
}

class Contact {
  Contact({
    @required this.telegram,
    @required this.phoneCall,
    @required this.whatsApp,
  });

  final String telegram;
  final String phoneCall;
  final String whatsApp;

  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        telegram: json["telegram"],
        phoneCall: json["phoneCall"],
        whatsApp: json["whatsApp"],
      );

  Map<String, dynamic> toMap() => {
        "telegram": telegram,
        "phoneCall": phoneCall,
        "whatsApp": whatsApp,
      };
}
