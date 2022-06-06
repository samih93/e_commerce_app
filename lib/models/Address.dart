import 'dart:convert';
import 'package:flutter/material.dart';

class Address {
  String? id,
      firstname,
      lastname,
      location,
      state,
      city,
      country,
      phone,
      postcode;

  Address(
      {this.id,
      this.firstname,
      this.lastname,
      this.location,
      this.state,
      this.city,
      this.country,
      this.phone,
      this.postcode});

  Address.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    id = map["id"];
    firstname = map["firstname"];
    lastname = map["lastname"];
    location = map["location"];
    state = map["state"];
    city = map["city"];
    postcode = map["postcode"];
    country = map["country"];
    phone = map["phone"];
  }

  toJson() {
    return {
      "id": id,
      'firstname': firstname,
      'lastname': lastname,
      'location': location,
      'state': state,
      'city': city,
      'postcode': postcode,
      'country': country,
      'phone': phone,
    };
  }
}
