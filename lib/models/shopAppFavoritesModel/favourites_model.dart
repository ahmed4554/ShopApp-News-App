class FavProduct {
  late final bool statue;
  String? message;
  FavData? data;
  FavProduct.fromJson(Map<String, dynamic> json) {
    statue = json['status'];
    message = json['message'];
    data = FavData.fromJson(json['data']);
  }
}

class FavData {
  int? id;
  num? price;
  num? old_price;
  num? dicount;
  String? image;
  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    dicount = json['dicount'];
    image = json['image'];
  }
}
