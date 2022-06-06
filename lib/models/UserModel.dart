class UserModel {
  String? userId, email, name, pic;

  UserModel({this.userId, this.email, this.name, this.pic});

  UserModel.fromjson(Map<dynamic, dynamic> Map) {
    if (Map == null) return;

    userId = Map["userId"];
    email = Map["email"];
    name = Map["name"];
    pic = Map["pic"];
  }

  tojson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
    };
  }
}
