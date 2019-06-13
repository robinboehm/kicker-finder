import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';

import 'flexibel-app-bar.widget.dart';

class StaticMapWidget extends StatelessWidget {
  final double long;
  final double lat;
  final String title;

  StaticMapWidget({Key key, this.long, this.lat, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String googleStaticMapApiAccessToken =
        '';
    var staticMapProvider =
        new StaticMapProvider(googleStaticMapApiAccessToken);
    var staticMapUri = staticMapProvider.getStaticUri(
        new Location(lat, long), 16,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);

    return FlexibleAppBar(title, staticMapUri.toString());
  }
}
