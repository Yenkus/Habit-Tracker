import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  Function()? onSave;
  Function()? onCancel;
  final String hintText;

  MyAlertBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            //border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
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
