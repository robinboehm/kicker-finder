import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'location.service.dart';

class LocationDetailArguments {
  final String id;

  LocationDetailArguments(this.id);
}

class LocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationDetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder<Location>(
              future: fetchLocation(http.Client(), args.id),
              builder: (context, snapshot) {
                final Location location = snapshot.data;
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(location.name),
                        Text(location.city),
                        Text(location.table),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return CircularProgressIndicator();
              },
            ),
          )),
    );
  }
}
