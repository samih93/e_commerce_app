class PaymentModel {
  String? id;
  String? name;
  String? number;
  String? expireddate;
  String? cvv;

  PaymentModel({this.id, this.name, this.number, this.expireddate, this.cvv});

  PaymentModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return;

    this.id = map['id'] != null ? map['id'].toString() : '';
    this.number = map['number'] != null ? map['number'].toString() : '';
    this.expireddate =
        map['expireddate'] != null ? map['expireddate'].toString() : '';
    this.cvv = map['cvv'] != null ? map['cvv'].toString() : '';
    this.name = map['name'] != null ? map['name'].toString() : '';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'expireddate': expireddate,
      'cvv': cvv,
    };
  }
}
