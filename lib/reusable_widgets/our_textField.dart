

 import 'package:flutter/cupertino.dart';

import '../consts/consts.dart';

Widget ourTextField({
 String? title,
 String? hint,
 controller,isPass
 }){
   return   TextField(
   obscureText: isPass,
   decoration: InputDecoration(
      labelText: title,
    hintText: hint,
    border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
   ),
  ),
  );
  }