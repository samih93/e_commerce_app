class PaymentModel {
  String id;
  String name;
  String number;
  String expireddate;
  String cvv;

  PaymentModel({this.id, this.name, this.number, this.expireddate, this.cvv});

  PaymentModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return;

    this.id = map['id'];
    this.number = map['number'];
    this.expireddate = map['expireddate'];
    this.cvv = map['cvv'];
    this.name = map['name'];
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
