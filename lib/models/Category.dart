// @dart=2.9

class Category {
  String categoryId, name, image;
  bool isselected = false;

  Category({this.categoryId, this.name, this.image});

  Category.fromjson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    this.categoryId = map['categoryId'];
    this.name = map['name'];
    this.image = map['image'];
  }

  tojson() {
    return {'categoryId': categoryId, 'name': name, 'image': image};
  }
}
