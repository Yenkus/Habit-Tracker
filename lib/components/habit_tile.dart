import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  String text;
  Function(bool?)? onChanged;
  bool isHabitChecked;

  HabitTile({
    super.key,
    required this.onChanged,
    required this.isHabitChecked,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          Checkbox(value: isHabitChecked, onChanged: onChanged),
          const Text('Just some stuff'),
        ],
      ),
    );
  }
}
