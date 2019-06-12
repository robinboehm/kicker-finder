import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<List<Location>> fetchLocations(http.Client client) async {
  final response = await http.get('http://localhost:4730/locations');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parseLocations, response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load location.');
  }
}

// A function that converts a response body into a List<Location>
List<Location> parseLocations(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Location>((json) => Location.fromJson(json)).toList();
}

Future<Location> fetchLocation(http.Client client, String id) async {
  final response = await http.get('http://localhost:4730/locations/' + id);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Location.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load location.');
  }
}

class Location {
  String id;
  String name;
  String street;
  String plz;
  String city;
  String subLocality;
  String loc;
  String homepage;
  String openingTimes;
  String table;
  String tableStatus;
  String price;
  String playingTimes;
  String skill;

  Location({
    this.id,
    this.name,
    this.street,
    this.plz,
    this.city,
    this.subLocality,
    this.loc,
    this.homepage,
    this.openingTimes,
    this.table,
    this.tableStatus,
    this.price,
    this.playingTimes,
    this.skill,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      plz: json['plz'],
      city: json['city'],
      subLocality: json['subLocality'],
      loc: json['loc'],
      homepage: json['homepage'],
      openingTimes: json['openingTimes'],
      table: json['table'],
      tableStatus: json['tableStatus'],
      price: json['price'],
      playingTimes: json['playingTimes'],
      skill: json['skill'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'street': street,
        'plz': plz,
        'city': city,
        'subLocality': subLocality,
        'loc': loc,
        'homepage': homepage,
        'openingTimes': openingTimes,
        'table': table,
        'tableStatus': tableStatus,
        'price': price,
        'playingTimes': playingTimes,
        'skill': skill,
      };

  save() async {
    final response = await http.Client()
        .post('http://localhost:4730/locations', body: toJson());

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load location.');
    }
  }
}
