import 'package:flutter/material.dart';

class NewHabitDialog extends StatelessWidget {
  final controller;
  Function()? onSave;
  Function()? onCancel;

  NewHabitDialog(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Enter new habit',
          border: OutlineInputBorder(),
          // focusedBorder: OutlineInputBorder()
        ),
      ),
      actions: [
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: onSave,
          child: const Text('Save'),
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
