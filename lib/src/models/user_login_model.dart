// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

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

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        token: json["token"],
        user: json["user"] != null
            ? LoginUser.fromJson(json["user"])
            : LoginUser(
                id: '',
                phone: '',
                create: LoginCreate(
                  city: '',
                  country: '',
                  createDateUser: '',
                  department: '',
                  latLng: LoginLatLng(
                    lat: 0,
                    lng: 0,
                  ),
                ),
              ),
        store: json["store"] != null
            ? LoginStore.fromJson(json["store"])
            : LoginStore(
                category: '',
                createData: '',
                id: '',
                nameStore: '',
                storeId: '',
                urlImage: '',
                visibility: false,
                address: [],
                contact: LoginContact(
                  phoneCall: '',
                  telegram: '',
                  whatsApp: '',
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "user": user.toJson(),
        "store": store.toJson(),
      };
}

class LoginStore {
  LoginStore({
    @required this.id,
    @required this.storeId,
    @required this.category,
    @required this.urlImage,
    @required this.nameStore,
    @required this.visibility,
    @required this.createData,
    @required this.address,
    @required this.contact,
  });

  final String id;
  final String storeId;
  final String category;
  final String urlImage;
  final String nameStore;
  final bool visibility;
  final String createData;
  final List<LoginCreate> address;
  final LoginContact contact;

  factory LoginStore.fromJson(Map<String, dynamic> json) => LoginStore(
        id: json["_id"],
        storeId: json["id"],
        category: json["category"],
        urlImage: json["urlImage"],
        nameStore: json["nameStore"],
        visibility: json["visibility"],
        createData: json["createData"],
        address: List<LoginCreate>.from(
            json["address"].map((x) => LoginCreate.fromJson(x))),
        contact: LoginContact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": storeId,
        "category": category,
        "urlImage": urlImage,
        "nameStore": nameStore,
        "visibility": visibility,
        "createData": createData,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "contact": contact.toJson(),
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

  factory LoginCreate.fromJson(Map<String, dynamic> json) => LoginCreate(
        city: json["city"],
        country: json["country"],
        department: json["department"],
        latLng: LoginLatLng.fromJson(json["latLng"]),
        createDateUser:
            json["createDateUser"] == null ? null : json["createDateUser"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "department": department,
        "latLng": latLng.toJson(),
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

  factory LoginLatLng.fromJson(Map<String, dynamic> json) => LoginLatLng(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
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

  factory LoginContact.fromJson(Map<String, dynamic> json) => LoginContact(
        telegram: json["telegram"],
        phoneCall: json["phoneCall"],
        whatsApp: json["whatsApp"],
      );

  Map<String, dynamic> toJson() => {
        "telegram": telegram,
        "phoneCall": phoneCall,
        "whatsApp": whatsApp,
      };
}

class LoginUser {
  LoginUser({
    @required this.id,
    @required this.phone,
    @required this.create,
  });

  final String id;
  final String phone;
  final LoginCreate create;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        id: json["id"],
        phone: json["phone"],
        create: LoginCreate.fromJson(json["create"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "create": create.toJson(),
      };
}
