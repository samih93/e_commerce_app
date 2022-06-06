import 'package:e_commerce_app/models/Product.dart';

class favoriteProduct {
  Product? product;
  bool? isfavorite;

  favoriteProduct({this.product, this.isfavorite});

  favoriteProduct.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    product =
        Product(); // without this have no access to all parameter in product
    product?.id = map["productId"];
    product?.name = map["name"];
    product?.image = map["image"];
    product?.description = map["description"];
    product?.price = map["price"].toString();
    isfavorite = map["isFavorite"] == 1 ? true : false;
  }

  toJson() {
    return {
      "productId": product?.id,
      "name": product?.name,
      "image": product?.images.first,
      "description": product?.description,
      "price": product?.price,
      "isFavorite": isfavorite
    };
  }
}
