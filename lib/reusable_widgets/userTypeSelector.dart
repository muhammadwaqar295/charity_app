import 'package:flutter/material.dart';

class UserTypeSelector extends StatelessWidget {
  final String? selectedUserType;
  final Function(String?) onSelectionChanged;

  const UserTypeSelector({
    super.key,
    required this.selectedUserType,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text("Donars"),
            selected: selectedUserType == "Donars",
            onSelected: (bool selected) {
              onSelectionChanged(selected ? "Donars" : null);
            },
            backgroundColor: Colors.grey[200],
            selectedColor: Colors.amber[700],
            labelStyle: TextStyle(
              color: selectedUserType == "Donars" ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ChoiceChip(
            label: const Text("Requester"),
            selected: selectedUserType == "Requester",
            onSelected: (bool selected) {
              onSelectionChanged(selected ? "Requester" : null);
            },
            backgroundColor: Colors.grey[200],
            selectedColor: Colors.amber[700],
            labelStyle: TextStyle(
              color: selectedUserType == "Requester" ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
