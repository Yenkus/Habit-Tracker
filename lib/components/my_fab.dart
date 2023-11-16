import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  Function()? onPressed;

  MyFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
