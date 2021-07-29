import 'package:meta/meta.dart';

class AddressModel {
  final String city;
  final String country;
  final String department;

  AddressModel({
    @required this.city,
    @required this.country,
    @required this.department,
  });

  @override
  String toString() {
    final String result =
        "AddressModel - city: ${this.city} - department: ${this.department} - country: ${this.country}";
    return result;
  }
}
