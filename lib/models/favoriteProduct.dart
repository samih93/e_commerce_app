class favoriteProduct {
  String productId;
  bool isfavorite;

  favoriteProduct({this.productId, this.isfavorite});

  favoriteProduct.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    productId = map["productId"];
    isfavorite = map["isFavorite"] == 1 ? true : false;
  }

  toJson() {
    return {"productId": productId, "isFavorite": isfavorite};
  }
}
