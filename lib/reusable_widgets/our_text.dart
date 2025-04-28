import 'package:flutter/cupertino.dart';

     Widget ourText({
       required Color color,
       required String title,
       required double textSize,
        Color? bgColor,




    }){
     return Text(
    title,
       textAlign: TextAlign.justify,
    style: TextStyle(
      backgroundColor: bgColor,
    fontSize: textSize,
   fontWeight: FontWeight.bold,
    color: color,

  ),
   );

}