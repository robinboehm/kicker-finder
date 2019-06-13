import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<List<KickerLocation>> fetchLocations(http.Client client) async {
  final response = await http.get('http://localhost:3000/locations');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parseLocations, response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load location.');
  }
}

// A function that converts a response body into a List<Location>
List<KickerLocation> parseLocations(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<KickerLocation>((json) => KickerLocation.fromJson(json)).toList();
}

Future<KickerLocation> fetchLocation(http.Client client, String id) async {
  final response = await http.get('http://localhost:3000/locations/' + id);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return KickerLocation.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load location.');
  }
}

class Loc {
  String long;
  String lat;

  Loc({this.long, this.lat});

  factory Loc.fromJson(Map<String, dynamic> json) {
    return Loc(long: json['long'], lat: json['lat']);
  }

  Map<String, dynamic> toJson() => {
        'long': long,
        'lat': lat,
      };
}

class KickerLocation {
  String id;
  String name;
  String street;
  String plz;
  String city;
  String subLocality;
  Loc loc;
  String homepage;
  String openingTimes;
  String table;
  String tableStatus;
  String price;
  String playingTimes;
  String skill;

  KickerLocation({
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

  factory KickerLocation.fromJson(Map<String, dynamic> json) {
    return KickerLocation(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      plz: json['plz'],
      city: json['city'],
      subLocality: json['subLocality'],
      loc: Loc.fromJson(json['loc']),
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
        'loc': loc.toJson(),
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
        .post('http://localhost:3000/locations', body: toJson());

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load location.');
    }
  }
}
