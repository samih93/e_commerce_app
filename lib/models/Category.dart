class Category {
  String name, image;

  Category({this.name, this.image});

  Category.fromjson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    this.name = map['name'];
    this.image = map['image'];
  }

  tojson() {
    return {'name': name, 'image': image};
  }
}
