import 'package:flutter/material.dart';

Widget ourMultilineTextField({
  required String title,
   required String hint,
  TextEditingController? controller,
}) {
  return SizedBox(
    height: 200,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: null,
      expands: true,
      style: const TextStyle(fontSize: 18),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        labelText: title,
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 18,
          height: 3,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
