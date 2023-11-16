import 'package:flutter/material.dart';
import 'package:habit_tracker/components/dialog_box.dart';

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
