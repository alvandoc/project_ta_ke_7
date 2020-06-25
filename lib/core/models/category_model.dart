
import 'package:flutter/cupertino.dart';

class CategoryModel {
  int id;
  int icon;
  String name;
  DateTime createdAt;

  CategoryModel({
    this.id, this.icon,
    this.name, this.createdAt
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: int.parse(map["id"].toString()) ?? 0,
      icon: int.parse(map["icon"].toString()) ?? 0,
      name: map["name"] ?? "",
      createdAt: DateTime.parse(map["created_at"])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "icon": icon,
      "name": name,
      "created_at": DateTime.now().toString()
    };
  }
}