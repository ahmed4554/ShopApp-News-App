class SearchModel {
  bool? status;
  Data? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late List<Item> data;
  Data.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) {
      return Item.fromJson(e);
    }).toList();
  }
}

class Item {
  int? id;
  late String name;
  late String description;
  late String image;
  late num price;
  late bool in_favorites;
  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    in_favorites = json['in_favorites'];
  }
}
