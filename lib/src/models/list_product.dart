// To parse this JSON data, do
//
//     final listProduct = listProductFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListProduct listProductFromMap(String str) =>
    ListProduct.fromMap(json.decode(str));

String listProductToMap(ListProduct data) => json.encode(data.toMap());

class ListProduct {
  ListProduct({
    @required this.success,
    @required this.listProduct,
  });

  final bool success;
  final List<ListProductElement> listProduct;

  factory ListProduct.fromMap(Map<String, dynamic> json) => ListProduct(
        success: json["success"] == null ? null : json["success"],
        listProduct: json["listProduct"] == null
            ? null
            : List<ListProductElement>.from(
                json["listProduct"].map((x) => ListProductElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "listProduct": listProduct == null
            ? null
            : List<dynamic>.from(listProduct.map((x) => x.toMap())),
      };
}

class ListProductElement {
  ListProductElement({
    @required this.idMongo,
    @required this.id,
    @required this.availabilityProductStore,
    @required this.nameProductStore,
    @required this.priceProductStore,
    @required this.quantityProductStore,
    @required this.categoryProductStore,
    @required this.urlImageProductStore,
  });

  final String idMongo;
  final String id;
  final bool availabilityProductStore;
  final String nameProductStore;
  final String priceProductStore;
  final String quantityProductStore;
  final String categoryProductStore;
  final String urlImageProductStore;

  factory ListProductElement.fromMap(Map<String, dynamic> json) =>
      ListProductElement(
        idMongo: json["_idMongo"] == null ? null : json["_idMongo"],
        id: json["id"] == null ? null : json["id"],
        availabilityProductStore: json["availabilityProductStore"] == null
            ? null
            : json["availabilityProductStore"],
        nameProductStore:
            json["nameProductStore"] == null ? null : json["nameProductStore"],
        priceProductStore: json["priceProductStore"] == null
            ? null
            : json["priceProductStore"],
        quantityProductStore: json["quantityProductStore"] == null
            ? null
            : json["quantityProductStore"],
        categoryProductStore: json["categoryProductStore"] == null
            ? null
            : json["categoryProductStore"],
        urlImageProductStore: json["urlImageProductStore"] == null
            ? null
            : json["urlImageProductStore"],
      );

  Map<String, dynamic> toMap() => {
        "_idMongo": idMongo == null ? null : idMongo,
        "id": id == null ? null : id,
        "availabilityProductStore":
            availabilityProductStore == null ? null : availabilityProductStore,
        "nameProductStore": nameProductStore == null ? null : nameProductStore,
        "priceProductStore":
            priceProductStore == null ? null : priceProductStore,
        "quantityProductStore":
            quantityProductStore == null ? null : quantityProductStore,
        "categoryProductStore":
            categoryProductStore == null ? null : categoryProductStore,
        "urlImageProductStore":
            urlImageProductStore == null ? null : urlImageProductStore,
      };
}
