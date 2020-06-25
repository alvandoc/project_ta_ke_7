
import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';

class ProdukModel {
  int id;
  String title;
  int stock;
  String description;
  int price;
  String image;
  String category;
  int categoryId;
  int categoryIcon;
  DateTime createdAt;

  ProdukModel({
    this.id, this.title,
    this.stock, this.description,
    this.price, this.image,
    this.category, this.createdAt,
    this.categoryIcon, this.categoryId
  });

  factory ProdukModel.fromJson(Map<String, dynamic> map) {
    return ProdukModel(
      id: int.parse(map["id"].toString()) ?? 0,
      title: map["title"] ?? "",
      stock: int.parse(map["stock"].toString()) ?? 0,
      description: map["description"] ?? "",
      price: int.parse(map["price"].toString()) ?? 0,
      image: map["image"] ?? 0,
      category: map["category"] ?? "",
      categoryId: map["category_id"] ?? 0,
      categoryIcon: int.parse(map["category_icon"].toString()) ?? 0
    );
  }

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data["title"] = title;
    data["stock"] = stock;
    data["description"] = description;
    data["price"] = price;

    if (image != null) {
      data["image"] = image;
    }

    data["category_id"] = categoryId;
    data["created_at"] = DateTime.now().toString();
    return data;
  }
}