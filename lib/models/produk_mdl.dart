class ProdModel {
  String id;
  String title;
  int jumlah;
  String deskripsi;
  double harga;
  String image;

  ProdModel(
      {this.id,
      this.title,
      this.jumlah,
      this.deskripsi,
      this.harga,
      this.image});

//Converter dari map ke object
  factory ProdModel.fromMap(Map<String, dynamic> map) {
    return ProdModel(
        id: map['id'].toString(),
        title: map['title'].toString(),
        jumlah: int.parse(map['jumlah'].toString()),
        deskripsi: map['deskripsi'].toString(),
        harga: double.parse(map['harga'].toString()),
        image: map['image']);
  }

// Converter dari object ke map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['jumlah'] = jumlah;
    map['deskripsi'] = deskripsi;
    map['harga'] = harga;
    map['image'] = image;

    return map;
  }
}
