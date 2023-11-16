import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  String habitText;
  Function(bool?)? onChanged;
  bool isHabitChecked;

  HabitTile({
    super.key,
    required this.onChanged,
    required this.isHabitChecked,
    required this.habitText,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            Checkbox(
              value: isHabitChecked,
              onChanged: onChanged,
            ),
            Text(habitText),
          ],
        ),
      ),
    );
  }
}
