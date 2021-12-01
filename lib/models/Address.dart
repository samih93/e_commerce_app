class Address {
  String firstname, lastname, address, state, city, country, phone, postcode;

  Address(
      {this.firstname,
      this.lastname,
      this.address,
      this.state,
      this.city,
      this.postcode,
      this.country,
      this.phone});

  Address.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    this.firstname = map["firstname"];
    this.lastname = map["lastname"];
    this.address = map["address"];
    this.state = map["state"];
    this.city = map["city"];
    this.postcode = map["postcode"];
    this.country = map["country"];
    this.phone = map["phone"];
  }

  toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'state': state,
      'city': city,
      'postcode': postcode,
      'country': country,
      'phone': phone,
    };
  }
}
