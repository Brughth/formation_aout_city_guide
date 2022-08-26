import 'package:city_guide/items/data/models/city_model.dart';

class ItemModel {
  late int id;
  late String name;
  late CityModel city;
  String? website;
  String? cover;

  ItemModel({
    required this.id,
    required this.name,
    required this.city,
    this.website,
    this.cover,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      city: CityModel.fromJson(json['city']),
      website: json['website'],
      cover: json['image'],
    );
  }
}
