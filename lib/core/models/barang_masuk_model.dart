
class BarangMasukRequest {
  int id;
  int produkId;
  int quantity;
  String vendor;
  DateTime createdAt;

  BarangMasukRequest({
    this.id, this.produkId, this.vendor,
    this.quantity, this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      "produk_id": produkId,
      "quantity": quantity,
      "vendor": vendor,
      "created_at": DateTime.now().toString()
    };
  }
}


class BarangMasukModel {
  int id;
  String title;
  int stock;
  String description;
  int price;
  String image;
  String category;
  int categoryId;
  int categoryIcon;
  int quantity;
  String vendor;
  int produkId;
  DateTime createdAt;

  BarangMasukModel({
    this.id, this.title,
    this.stock, this.description,
    this.price, this.image,
    this.category, this.createdAt,
    this.quantity, this.produkId, this.vendor,
    this.categoryIcon, this.categoryId
  });

  factory BarangMasukModel.fromJson(Map<String, dynamic> map) {
    return BarangMasukModel(
      id: int.parse(map["id"].toString()) ?? 0,
      produkId: int.parse(map["produk_id"].toString()) ?? 0,
      title: map["title"] ?? "",
      stock: int.parse(map["stock"].toString()) ?? 0,
      description: map["description"] ?? "",
      price: int.parse(map["price"].toString()) ?? 0,
      image: map["image"] ?? 0,
      category: map["category"] ?? "",
      categoryId: map["category_id"] ?? 0,
      categoryIcon: int.parse(map["category_icon"].toString()) ?? 0,
      quantity: int.parse(map["quantity"].toString()) ?? 0,
      vendor: map["vendor"] ?? ""
    );
  }
}
