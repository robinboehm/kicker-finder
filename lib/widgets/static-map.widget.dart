import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';

class StaticMapWidget extends StatelessWidget {
  final double long;
  final double lat;

  StaticMapWidget({Key key, this.long, this.lat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String googleStaticMapApiAccessToken =
        '';
    var staticMapProvider =
        new StaticMapProvider(googleStaticMapApiAccessToken);
    var staticMapUri = staticMapProvider.getStaticUri(
        new Location(lat, long), 16,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);

    return InkWell(
      child: new Center(
        child: new Image.network(staticMapUri.toString()),
      ),
    );
  }
}
