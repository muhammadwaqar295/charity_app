import 'package:flutter/material.dart';

Widget ourBackButton(BuildContext context, {Color iconColor = Colors.black}) {
  return IconButton(
    icon: Icon(Icons.arrow_back, color: iconColor),
    onPressed: () => Navigator.pop(context),
  );
}
