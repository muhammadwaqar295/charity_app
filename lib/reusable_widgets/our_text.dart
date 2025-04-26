import 'package:flutter/cupertino.dart';

     Widget ourText({
       required Color color,
       required String title,
       required double textSize,




    }){
     return Text(
    title,
    style: TextStyle(
    fontSize: textSize,
   fontWeight: FontWeight.bold,
    color: color,
  ),
   );

}