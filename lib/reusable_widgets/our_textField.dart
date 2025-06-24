import '../consts/consts.dart';

Widget ourTextField({
 String? title,
 String? hint,
  bool isPass = false,
  controller
 }){
   return   TextField(
   obscureText: isPass,
   controller: controller,
   decoration: InputDecoration(
      labelText: title,
    hintText: hint,
    border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
   ),
  ),
  );
  }