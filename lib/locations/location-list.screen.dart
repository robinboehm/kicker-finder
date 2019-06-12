import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'location-detail.screen.dart';
import 'location.service.dart';

class LocationList extends StatelessWidget {
  LocationList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kicker Finder'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Location>>(
                future: fetchLocations(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(
                              '${snapshot.data[index].city} - ${snapshot.data[index].table}'),
                          leading: Icon(Icons.home),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/location',
                              arguments: LocationDetailArguments(
                                '${snapshot.data[index].id}',
                              ),
                            );
                          },
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
          ],
        ),
      ),
    );
  }
}
