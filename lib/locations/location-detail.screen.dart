import 'package:flutter/material.dart';
import 'package:kicker_finder/widgets/flexibel-app-bar.widget.dart';
import 'package:kicker_finder/widgets/static-map.widget.dart';

import 'package:map_view/map_view.dart';

import 'location.service.dart';

class LocationDetailArguments {
  final KickerLocation location;

  LocationDetailArguments(this.location);
}

class LocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationDetailArguments args =
        ModalRoute.of(context).settings.arguments;
    final KickerLocation location = args.location;

    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          StaticMapWidget(
              title: location.name,
              lat: double.parse(location.loc.lat),
              long: double.parse(location.loc.long)),
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
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
            ]),
          )
        ],
      ),
    );
  }
}
