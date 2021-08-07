import 'package:meta/meta.dart';
import 'dart:convert';

// CacheStoreModel cacheStoreModelFromMap(String str) =>
//     CacheStoreModel.fromMap(json.decode(str));

// String cacheStoreModelToMap(CacheStoreModel data) => json.encode(data.toMap());

// class CacheStoreModel {
//   CacheStoreModel({
//     @required this.success,
//     @required this.storeModel,
//   });

//   final bool success;
//   final List<StoreModel> storeModel;

//   factory CacheStoreModel.fromMap(Map<String, dynamic> json) => CacheStoreModel(
//         success: json["success"],
//         storeModel: List<StoreModel>.from(
//             json["storesModel"]?.map((x) => StoreModel.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "success": success,
//         "storesModel": List<dynamic>.from(storeModel.map((x) => x.toMap())),
//       };
// }

// class StoreModel {
//   StoreModel({
//     @required this.id,
//     @required this.allStoreId,
//     @required this.category,
//     @required this.urlImageStore,
//     @required this.description,
//     @required this.nameStore,
//     @required this.visibility,
//     @required this.createData,
//     @required this.address,
//     @required this.contact,
//   });

//   final String id;
//   final String allStoreId;
//   final String category;
//   final String urlImageStore;
//   final String description;
//   final String nameStore;
//   final bool visibility;
//   final String createData;
//   final List<Address> address;
//   final Contact contact;

//   factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
//         id: json["_id"],
//         allStoreId: json["id"],
//         category: json["category"],
//         urlImageStore: json["urlImageStore"],
//         description: json["description"],
//         nameStore: json["nameStore"],
//         visibility: json["visibility"],
//         createData: json["createData"],
//         address:
//             List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
//         contact: Contact.fromMap(json["contact"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id,
//         "id": allStoreId,
//         "category": category,
//         "urlImageStore": urlImageStore,
//         "description": description,
//         "nameStore": nameStore,
//         "visibility": visibility,
//         "createData": createData,
//         "address": List<dynamic>.from(address.map((x) => x.toMap())),
//         "contact": contact.toMap(),
//       };
// }

// class Address {
//   Address({
//     @required this.city,
//     @required this.country,
//     @required this.department,
//     @required this.latLng,
//   });

//   final String city;
//   final String country;
//   final String department;
//   final StoreLatLng latLng;

//   factory Address.fromMap(Map<String, dynamic> json) => Address(
//         city: json["city"],
//         country: json["country"],
//         department: json["department"],
//         latLng: StoreLatLng.fromMap(json["latLng"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "city": city,
//         "country": country,
//         "department": department,
//         "latLng": latLng.toMap(),
//       };
// }

// class StoreLatLng {
//   StoreLatLng({
//     @required this.lat,
//     @required this.lng,
//   });

//   final double lat;
//   final double lng;

//   factory StoreLatLng.fromMap(Map<String, dynamic> json) => StoreLatLng(
//         lat: json["lat"].toDouble(),
//         lng: json["lng"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "lat": lat,
//         "lng": lng,
//       };
// }

// class Contact {
//   Contact({
//     @required this.telegram,
//     @required this.phoneCall,
//     @required this.whatsApp,
//   });

//   final String telegram;
//   final String phoneCall;
//   final String whatsApp;

//   factory Contact.fromMap(Map<String, dynamic> json) => Contact(
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

///////////////////////////////
// To parse this JSON data, do
//
//     final cacheStoreModel = cacheStoreModelFromMap(jsonString);

CacheStoreModel cacheStoreModelFromMap(String str) =>
    CacheStoreModel.fromMap(json.decode(str));

String cacheStoreModelToMap(CacheStoreModel data) => json.encode(data.toMap());

class CacheStoreModel {
  CacheStoreModel({
    @required this.success,
    @required this.storeModel,
  });

  final bool success;
  final List<StoreModel> storeModel;

  factory CacheStoreModel.fromMap(Map<String, dynamic> json) => CacheStoreModel(
        success: json["success"] == null ? null : json["success"],
        storeModel: json["storesModel"] == null
            ? null
            : List<StoreModel>.from(
                json["storesModel"].map((x) => StoreModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "storesModel": storeModel == null
            ? null
            : List<dynamic>.from(storeModel.map((x) => x.toMap())),
      };
}

class StoreModel {
  StoreModel({
    @required this.id,
    @required this.allStoreId,
    @required this.categoryStore,
    @required this.iconPathCategoryStore,
    @required this.descriptionStore,
    @required this.urlImageStore,
    @required this.nameStore,
    @required this.visibilityStore,
    @required this.createDataStore,
    @required this.addressStore,
    @required this.contactStore,
  });

  final String id;
  final String allStoreId;
  final String categoryStore;
  final String iconPathCategoryStore;
  final String descriptionStore;
  final String urlImageStore;
  final String nameStore;
  final bool visibilityStore;
  final String createDataStore;
  final List<AddressStore> addressStore;
  final ContactStore contactStore;

  factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
        id: json["_id"] == null ? null : json["_id"],
        urlImageStore:
            json["urlImageStore"] == null ? null : json["urlImageStore"],
        allStoreId: json["id"] == null ? null : json["id"],
        categoryStore:
            json["categoryStore"] == null ? null : json["categoryStore"],
        iconPathCategoryStore: json["iconPathCategoryStore"] == null
            ? null
            : json["iconPathCategoryStore"],
        descriptionStore:
            json["descriptionStore"] == null ? null : json["descriptionStore"],
        nameStore: json["nameStore"] == null ? null : json["nameStore"],
        visibilityStore:
            json["visibilityStore"] == null ? null : json["visibilityStore"],
        createDataStore:
            json["createDataStore"] == null ? null : json["createDataStore"],
        addressStore: json["addressStore"] == null
            ? null
            : List<AddressStore>.from(
                json["addressStore"].map((x) => AddressStore.fromMap(x))),
        contactStore: json["contactStore"] == null
            ? null
            : ContactStore.fromMap(json["contactStore"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "urlImageStore": urlImageStore == null ? null : urlImageStore,
        "id": allStoreId == null ? null : allStoreId,
        "categoryStore": categoryStore == null ? null : categoryStore,
        "iconPathCategoryStore":
            iconPathCategoryStore == null ? null : iconPathCategoryStore,
        "descriptionStore": descriptionStore == null ? null : descriptionStore,
        "nameStore": nameStore == null ? null : nameStore,
        "visibilityStore": visibilityStore == null ? null : visibilityStore,
        "createDataStore": createDataStore == null ? null : createDataStore,
        "addressStore": addressStore == null
            ? null
            : List<dynamic>.from(addressStore.map((x) => x.toMap())),
        "contactStore": contactStore == null ? null : contactStore.toMap(),
      };
}

class AddressStore {
  AddressStore({
    @required this.city,
    @required this.country,
    @required this.department,
    @required this.latLngStore,
  });

  final String city;
  final String country;
  final String department;
  final LatLngStore latLngStore;

  factory AddressStore.fromMap(Map<String, dynamic> json) => AddressStore(
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        department: json["department"] == null ? null : json["department"],
        latLngStore: json["latLngStore"] == null
            ? null
            : LatLngStore.fromMap(json["latLngStore"]),
      );

  Map<String, dynamic> toMap() => {
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "department": department == null ? null : department,
        "latLngStore": latLngStore == null ? null : latLngStore.toMap(),
      };
}

class LatLngStore {
  LatLngStore({
    @required this.lat,
    @required this.lng,
  });

  final double lat;
  final double lng;

  factory LatLngStore.fromMap(Map<String, dynamic> json) => LatLngStore(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class ContactStore {
  ContactStore({
    @required this.telegram,
    @required this.phoneCall,
    @required this.whatsApp,
  });

  final String telegram;
  final String phoneCall;
  final String whatsApp;

  factory ContactStore.fromMap(Map<String, dynamic> json) => ContactStore(
        telegram: json["telegram"] == null ? null : json["telegram"],
        phoneCall: json["phoneCall"] == null ? null : json["phoneCall"],
        whatsApp: json["whatsApp"] == null ? null : json["whatsApp"],
      );

  Map<String, dynamic> toMap() => {
        "telegram": telegram == null ? null : telegram,
        "phoneCall": phoneCall == null ? null : phoneCall,
        "whatsApp": whatsApp == null ? null : whatsApp,
      };
}
