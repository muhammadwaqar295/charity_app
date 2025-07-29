import 'package:flutter/material.dart';

class RequesterImages extends StatelessWidget {
  final String label;
  final VoidCallback onPress;

  const RequesterImages({super.key, required this.label, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade300, // Light gray background
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Number in black
            ),
          ),
        ),
      ),
    );
  }
}
