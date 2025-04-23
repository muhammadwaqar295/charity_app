import 'package:charity_app/consts/consts.dart';

Widget ourButton2({
  required VoidCallback onPress,
  required String title,
}){ return
   OutlinedButton(
    style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
   shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(10),
   ),
  side: const BorderSide(color: blackColor),
   ),
   onPressed: onPress,
   child:  Text(
   title,
    style: const TextStyle(color: blackColor, fontSize: 16),
  ),
  );



}