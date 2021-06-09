// To parse this JSON data, do
//
//     final loadJsonCategories = loadJsonCategoriesFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

LoadJsonCategories loadJsonCategoriesFromJson(String str) =>
    LoadJsonCategories.fromJson(json.decode(str));

String loadJsonCategoriesToJson(LoadJsonCategories data) =>
    json.encode(data.toJson());

class LoadJsonCategories {
  LoadJsonCategories({
    @required this.supermercado,
  });

  final List<Supermercado> supermercado;

  factory LoadJsonCategories.fromJson(Map<String, dynamic> json) =>
      LoadJsonCategories(
        supermercado: List<Supermercado>.from(
            json["supermercado"].map((x) => Supermercado.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "supermercado": List<dynamic>.from(supermercado.map((x) => x.toJson())),
      };
}

class Supermercado {
  Supermercado({
    @required this.name,
  });

  final String name;

  factory Supermercado.fromJson(Map<String, dynamic> json) => Supermercado(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
