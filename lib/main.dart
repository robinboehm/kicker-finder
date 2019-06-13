import 'package:flutter/material.dart';

import 'locations/location-detail.screen.dart';
import 'locations/location-list.screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kicker Finder',
      initialRoute: '/',
      routes: {
        '/': (context) => LocationList(),
        '/location': (context) => LocationDetail(),
      },
    );
  }
}