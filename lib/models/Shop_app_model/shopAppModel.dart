class ShopAppModel {
  bool? status;
  late String message;
  ShopAppModelData? data;
  ShopAppModel.init({required Map<String, dynamic> map}) {
    status = map['status'];
    map['message'] == null ? message = '' : message = map['message'];
    data = map['data'] != null ? ShopAppModelData.init(map: map['data']) : null;
  }
}

class ShopAppModelData {
  int? id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  ShopAppModelData.init({required Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    image = map['image'];
    token = map['token'];
  }
}
