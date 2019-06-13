import 'package:flutter/material.dart';

import 'location.service.dart';

class LocationDetailArguments {
  final Location location;

  LocationDetailArguments(this.location);
}

class LocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationDetailArguments args =
        ModalRoute.of(context).settings.arguments;
    final Location location = args.location;

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Text(location.name),
                Text(location.city),
                Text(location.table),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
