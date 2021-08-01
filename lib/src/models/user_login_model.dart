// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel({
    @required this.success,
    @required this.token,
    @required this.user,
    @required this.store,
  });

  final bool success;
  final String token;
  final LoginUser user;
  final LoginStore store;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        token: json["token"],
        user: LoginUser.fromMap(json["user"]),
        store: LoginStore.fromMap(json["store"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "token": token,
        "user": user.toMap(),
        "store": store.toMap(),
      };
}

class LoginStore {
  LoginStore({
    @required this.id,
    @required this.storeId,
    @required this.category,
    @required this.iconPathCategory,
    @required this.urlImage,
    @required this.description,
    @required this.nameStore,
    @required this.visibility,
    @required this.address,
    @required this.contact,
  });

  final String id;
  final String storeId;
  final String category;
  final String iconPathCategory;
  final String urlImage;
  final String description;
  final String nameStore;
  final bool visibility;
  final List<LoginCreate> address;
  final LoginContact contact;

  factory LoginStore.fromMap(Map<String, dynamic> json) => LoginStore(
        id: json["_id"],
        storeId: json["id"],
        category: json["category"],
        iconPathCategory: json["iconPathCategory"],
        urlImage: json["urlImage"],
        description: json["description"],
        nameStore: json["nameStore"],
        visibility: json["visibility"],
        address: List<LoginCreate>.from(
            json["address"].map((x) => LoginCreate.fromMap(x))),
        contact: LoginContact.fromMap(json["contact"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "id": storeId,
        "category": category,
        "iconPathCategory": iconPathCategory,
        "urlImage": urlImage,
        "description": description,
        "nameStore": nameStore,
        "visibility": visibility,
        "address": List<dynamic>.from(address.map((x) => x.toMap())),
        "contact": contact.toMap(),
      };
}

class LoginCreate {
  LoginCreate({
    @required this.city,
    @required this.country,
    @required this.department,
    @required this.latLng,
    @required this.createDateUser,
  });

  final String city;
  final String country;
  final String department;
  final LoginLatLng latLng;
  final String createDateUser;

  factory LoginCreate.fromMap(Map<String, dynamic> json) => LoginCreate(
        city: json["city"],
        country: json["country"],
        department: json["department"],
        latLng: LoginLatLng.fromMap(json["latLng"]),
        createDateUser:
            json["createDateUser"] == null ? null : json["createDateUser"],
      );

  Map<String, dynamic> toMap() => {
        "city": city,
        "country": country,
        "department": department,
        "latLng": latLng.toMap(),
        "createDateUser": createDateUser == null ? null : createDateUser,
      };
}

class LoginLatLng {
  LoginLatLng({
    @required this.lat,
    @required this.lng,
  });

  final double lat;
  final double lng;

  factory LoginLatLng.fromMap(Map<String, dynamic> json) => LoginLatLng(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class LoginContact {
  LoginContact({
    @required this.telegram,
    @required this.phoneCall,
    @required this.whatsApp,
  });

  final String telegram;
  final String phoneCall;
  final String whatsApp;

  factory LoginContact.fromMap(Map<String, dynamic> json) => LoginContact(
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

class LoginUser {
  LoginUser({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.create,
  });

  final String id;
  final String name;
  final String phone;
  final LoginCreate create;

  factory LoginUser.fromMap(Map<String, dynamic> json) => LoginUser(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        create: LoginCreate.fromMap(json["create"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "create": create.toMap(),
      };
}
