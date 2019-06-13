import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'location-detail.screen.dart';
import 'location.service.dart';

class LocationList extends StatefulWidget {
  LocationList({Key key}) : super(key: key);

  @override
  _LocationSearchState createState() => new _LocationSearchState();
}

class _LocationSearchState extends State<LocationList> {
  TextEditingController editingController = TextEditingController();

  List<Location> items = new List<Location>();
  List<Location> originalItems = new List<Location>();

  Future<Null> getAllLocations() async {
    debugPrint("Fetch locations");
    final locations = await fetchLocations(http.Client());

    setState(() {
      debugPrint("Locations fetched");
      items.addAll(locations);
      originalItems.addAll(locations);
    });
  }

  @override
  void initState() {
    debugPrint("init state");
    super.initState();
    getAllLocations();
  }

  void filterSearchResults(String query) {
    List<Location> tempFilterList = new List<Location>();
    if (query.isNotEmpty) {
      originalItems.forEach((item) {
        if (item.name.contains(query) ||
            item.city.contains(query) ||
            item.table.contains(query)) {
          tempFilterList.add(item);
        }
      });
    } else {
      tempFilterList.addAll(originalItems);
    }

    setState(() {
      items.clear();
      items.addAll(tempFilterList);
    });
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].name),
          subtitle: Text('${items[index].city} - ${items[index].table}'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/location',
              arguments: LocationDetailArguments(
                '${items[index].id}',
              ),
            );
          },
        );
      },
    );
    // return Text(snapshot.data.title);
  }

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
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: buildList(),
            ),
          ],
        ),
      ),
    );
  }
}
