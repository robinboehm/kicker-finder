import 'package:flutter/material.dart';
import 'package:kicker_finder/widgets/contact-category-item.widget.dart';
import 'package:kicker_finder/widgets/contact-category.widget.dart';
import 'package:kicker_finder/widgets/flexibel-app-bar.widget.dart';
import 'package:kicker_finder/widgets/static-map.widget.dart';

import 'package:map_view/map_view.dart';

import 'location.service.dart';

class LocationDetailArguments {
  final KickerLocation location;

  LocationDetailArguments(this.location);
}

class LocationDetail extends StatelessWidget {

ContactCategory _buildAdressCategory(KickerLocation location) {
    return ContactCategory(
      icon: Icons.pin_drop,
      children:[
        ContactCategoryItem(
                          icon: Icons.map,
                          lines: <String>[
                            location.street,
                            '${location.plz} ${location.city}'
                          ],
                        )
      ]
    );
  }

  ContactCategory _buildContactCategory(KickerLocation location) {
    return ContactCategory(
      icon: Icons.contacts,
      children:[
        ContactCategoryItem(
                          icon: Icons.web,
                          lines: <String>[
                            location.homepage
                          ],
                        )
      ]
    );
  }

  ContactCategory _buildTablesCategory(KickerLocation location) {
    return ContactCategory(
      icon: Icons.games,
      children:[
        ContactCategoryItem(
                          icon: Icons.toys,
                          lines: <String>[
                            location.table
                          ],
                        )
      ]
    );
  }

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
                      _buildAdressCategory(location),
                      _buildContactCategory(location),
                      _buildTablesCategory(location),
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
