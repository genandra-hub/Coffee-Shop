import 'package:flutter/material.dart';
import 'package:goals/utils/functions.dart';

Widget buildTile(Widget widgetContent, {Function() onTap}) {
  return Container(
    margin: const EdgeInsets.all(9.0),
    child: Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: onTap != null
            ? () => onTap()
            : () {
                print("Nothing set");
              },
        child: widgetContent,
        splashColor: Colors.blue[500],
      ),
    ),
  );
}

Widget buildEmptyPage(BuildContext context) {
  return Container(
    child: Center(
      child: Text(
        "Start adding your goal...",
        style: TextStyle(
          color: invertColors(context),
          fontSize: 18.0,
        ),
      ),
    ),
  );
} 
