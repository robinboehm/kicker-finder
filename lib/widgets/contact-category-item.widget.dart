import 'package:flutter/material.dart';

class ContactCategoryItem extends StatelessWidget {

  final IconData icon;
  final List<String> lines;

  ContactCategoryItem({ Key key,  @required this.icon, @required this.lines })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildRow(context)
      )
    );
  }

  List<Widget> _buildRow(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> firstColumn = lines.map((line) => Text(line)).toList();

    return <Widget> [
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: firstColumn,
        )
      ),
      SizedBox(
        width: 72.0,
        child: IconButton(
          icon: Icon(icon),
          color: themeData.primaryColor,
          onPressed: () => {
            debugPrint('delegate an acion here')
          }
        )
      )
    ];
  }

}