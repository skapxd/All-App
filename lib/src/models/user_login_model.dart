// // To parse this JSON data, do
// //
// //     final loginModel = loginModelFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// LoginModel loginModelFromMap(String str) =>
//     LoginModel.fromMap(json.decode(str));

// String loginModelToMap(LoginModel data) => json.encode(data.toMap());

// class LoginModel {
//   LoginModel({
//     @required this.success,
//     @required this.token,
//     @required this.user,
//     @required this.store,
//   });

//   final bool success;
//   final String token;
//   final LoginUser user;
//   final LoginStore store;

//   factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
//         success: json["success"],
//         token: json["token"],
//         user: json["user"] != null
//             ? LoginUser.fromMap(json["user"])
//             : LoginUser(
//                 id: '',
//                 name: '',
//                 phone: '',
//                 create: LoginCreate(
//                   city: '',
//                   country: '',
//                   createDateUser: '',
//                   department: '',
//                   latLng: LoginLatLng(
//                     lat: 0.0,
//                     lng: 0.0,
//                   ),
//                 ),
//               ),
//         store: json["store"] != null
//             ? LoginStore.fromMap(json["store"])
//             : LoginStore(
//                 category: '',
//                 description: '',
//                 iconPathCategory: '',
//                 id: '',
//                 nameStore: '',
//                 storeId: '',
//                 urlImage: '',
//                 visibility: false,
//                 address: [],
//                 contact: LoginContact(
//                   phoneCall: '',
//                   telegram: '',
//                   whatsApp: '',
//                 ),
//               ),
//       );

//   Map<String, dynamic> toMap() => {
//         "success": success,
//         "token": token,
//         "user": user.toMap(),
//         "store": store.toMap(),
//       };
// }

// class LoginStore {
//   LoginStore({
//     @required this.id,
//     @required this.storeId,
//     @required this.category,
//     @required this.iconPathCategory,
//     @required this.urlImage,
//     @required this.description,
//     @required this.nameStore,
//     @required this.visibility,
//     @required this.address,
//     @required this.contact,
//   });

//   final String id;
//   final String storeId;
//   final String category;
//   final String iconPathCategory;
//   final String urlImage;
//   final String description;
//   final String nameStore;
//   final bool visibility;
//   final List<LoginCreate> address;
//   final LoginContact contact;

//   factory LoginStore.fromMap(Map<String, dynamic> json) => LoginStore(
//         id: json["_id"],
//         storeId: json["id"],
//         category: json["category"],
//         iconPathCategory: json["iconPathCategory"],
//         urlImage: json["urlImage"],
//         description: json["description"],
//         nameStore: json["nameStore"],
//         visibility: json["visibility"],
//         address: json["address"] != null
//             ? List<LoginCreate>.from(
//                 json["address"].map((x) => LoginCreate.fromMap(x)))
//             : [],
//         contact: LoginContact.fromMap(json["contact"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id,
//         "id": storeId,
//         "category": category,
//         "iconPathCategory": iconPathCategory,
//         "urlImage": urlImage,
//         "description": description,
//         "nameStore": nameStore,
//         "visibility": visibility,
//         "address": List<dynamic>.from(address.map((x) => x.toMap())),
//         "contact": contact.toMap(),
//       };
// }

// class LoginCreate {
//   LoginCreate({
//     @required this.city,
//     @required this.country,
//     @required this.department,
//     @required this.latLng,
//     @required this.createDateUser,
//   });

//   final String city;
//   final String country;
//   final String department;
//   final LoginLatLng latLng;
//   final String createDateUser;

//   factory LoginCreate.fromMap(Map<String, dynamic> json) => LoginCreate(
//         city: json["city"],
//         country: json["country"],
//         department: json["department"],
//         latLng: LoginLatLng.fromMap(json["latLng"]),
//         createDateUser:
//             json["createDateUser"] == null ? null : json["createDateUser"],
//       );

//   Map<String, dynamic> toMap() => {
//         "city": city,
//         "country": country,
//         "department": department,
//         "latLng": latLng.toMap(),
//         "createDateUser": createDateUser == null ? null : createDateUser,
//       };
// }

// class LoginLatLng {
//   LoginLatLng({
//     @required this.lat,
//     @required this.lng,
//   });

//   final double lat;
//   final double lng;

//   factory LoginLatLng.fromMap(Map<String, dynamic> json) => LoginLatLng(
//         lat: json["lat"].toDouble(),
//         lng: json["lng"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "lat": lat,
//         "lng": lng,
//       };
// }

// class LoginContact {
//   LoginContact({
//     @required this.telegram,
//     @required this.phoneCall,
//     @required this.whatsApp,
//   });

//   final String telegram;
//   final String phoneCall;
//   final String whatsApp;

//   factory LoginContact.fromMap(Map<String, dynamic> json) => LoginContact(
//         telegram: json["telegram"],
//         phoneCall: json["phoneCall"],
//         whatsApp: json["whatsApp"],
//       );

//   Map<String, dynamic> toMap() => {
//         "telegram": telegram,
//         "phoneCall": phoneCall,
//         "whatsApp": whatsApp,
//       };
// }

// class LoginUser {
//   LoginUser({
//     @required this.id,
//     @required this.name,
//     @required this.phone,
//     @required this.create,
//   });

//   final String id;
//   final String name;
//   final String phone;
//   final LoginCreate create;

//   factory LoginUser.fromMap(Map<String, dynamic> json) => LoginUser(
//         id: json["id"] == null ? '' : json["id"],
//         name: json["name"] == null ? '' : json["name"],
//         phone: json["phone"] == null ? '' : json["phone"],
//         create: LoginCreate.fromMap(json["create"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "phone": phone,
//         "create": create.toMap(),
//       };
// }

// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);
// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'package:allapp/src/models/store_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel welcomeFromMap(String str) => LoginModel.fromMap(json.decode(str));

String welcomeToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel({
    @required this.success,
    @required this.token,
    @required this.userLogin,
    @required this.storeLogin,
  });

  final bool success;
  final String token;
  final UserLogin userLogin;
  final StoreModel storeLogin;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        success: json["success"] == null ? null : json["success"],
        token: json["token"] == null ? null : json["token"],
        userLogin: json["userLogin"] == null
            ? null
            : UserLogin.fromMap(json["userLogin"]),
        storeLogin: json["storeLogin"] == null
            ? null
            : StoreModel.fromMap(json["storeLogin"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "token": token == null ? null : token,
        "userLogin": userLogin == null ? null : userLogin.toMap(),
        "storeLogin": storeLogin == null ? null : storeLogin.toMap(),
      };
}

class UserLogin {
  UserLogin({
    @required this.id,
    @required this.phoneUser,
    @required this.createUser,
    @required this.name,
  });

  final String id;
  final String phoneUser;
  final CreateUser createUser;
  final String name;

  factory UserLogin.fromMap(Map<String, dynamic> json) => UserLogin(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneUser: json["phoneUser"] == null ? null : json["phoneUser"],
        createUser: json["createUser"] == null
            ? null
            : CreateUser.fromMap(json["createUser"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "phoneUser": phoneUser == null ? null : phoneUser,
        "name": name == null ? null : name,
        "createUser": createUser == null ? null : createUser.toMap(),
      };
}

class CreateUser {
  CreateUser({
    @required this.country,
    @required this.department,
    @required this.city,
    @required this.createDateUser,
    @required this.latLngLogin,
  });

  final String country;
  final String department;
  final String city;
  final String createDateUser;
  final LatLngLogin latLngLogin;

  factory CreateUser.fromMap(Map<String, dynamic> json) => CreateUser(
        country: json["country"] == null ? null : json["country"],
        department: json["department"] == null ? null : json["department"],
        city: json["city"] == null ? null : json["city"],
        createDateUser:
            json["createDateUser"] == null ? null : json["createDateUser"],
        latLngLogin: json["latLngLogin"] == null
            ? null
            : LatLngLogin.fromMap(json["latLngLogin"]),
      );

  Map<String, dynamic> toMap() => {
        "country": country == null ? null : country,
        "department": department == null ? null : department,
        "city": city == null ? null : city,
        "createDateUser": createDateUser == null ? null : createDateUser,
        "latLngLogin": latLngLogin == null ? null : latLngLogin.toMap(),
      };
}

class LatLngLogin {
  LatLngLogin({
    @required this.lat,
    @required this.lng,
  });

  final double lat;
  final double lng;

  factory LatLngLogin.fromMap(Map<String, dynamic> json) => LatLngLogin(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
