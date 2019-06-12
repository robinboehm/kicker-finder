
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'location.service.dart';

class LocationList extends StatelessWidget {
  LocationList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kicker Finder'),
        ),
        body: Center(
          child: FutureBuilder<List<Location>>(
            future: fetchLocations(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${snapshot.data[index].name}'),
                          );
                        },
                      );
                // return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}
