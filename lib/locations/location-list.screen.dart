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

  List<Location> _items = new List<Location>();
  List<Location> _originalItems = new List<Location>();

  Future<Null> getAllLocations() async {
    debugPrint("Fetch locations");
    final locations = await fetchLocations(http.Client());

    setState(() {
      _items.addAll(locations);
      _originalItems.addAll(locations);
    });
  }

  @override
  void initState() {
    super.initState();
    getAllLocations();
  }

  void _filterSearchResults(String query) {
    List<Location> tempFilterList = new List<Location>();
    if (query.isNotEmpty) {
      _originalItems.forEach((item) {
        if (item.name.contains(query) ||
            item.city.contains(query) ||
            item.table.contains(query)) {
          tempFilterList.add(item);
        }
      });
    } else {
      tempFilterList.addAll(_originalItems);
    }

    setState(() {
      _items.clear();
      _items.addAll(tempFilterList);
    });
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_items[index].name),
          subtitle: Text('${_items[index].city} - ${_items[index].table}'),
          leading: Icon(Icons.home),
          onTap: () {_navigateToLocation(_items[index]);},
        );
      },
    );
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
                  _filterSearchResults(value);
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
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToLocation(Location location) {
    Navigator.pushNamed(
      context,
      '/location',
      arguments: LocationDetailArguments(location),
    );
  }
}
