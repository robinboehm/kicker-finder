import 'package:flutter/material.dart';

import 'contact-category-item.widget.dart';

class ContactCategory extends StatelessWidget {

  final IconData icon;
  final List<ContactCategoryItem> children;

  ContactCategory({Key key, this.icon, this.children}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: themeData.dividerColor))
      ),
      child: Row (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            width: 72.0,
            child: Icon(icon, color: themeData.primaryColor)
          ),
          Flexible(child: Column(children: children))
        ]
      )
    );
  }
}