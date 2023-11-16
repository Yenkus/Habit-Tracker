import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  String habitText;
  Function(bool?)? onChanged;
  bool isHabitChecked;
  Function(BuildContext)? settingsTapped;
  Function(BuildContext)? deleteTapped;

  HabitTile({
    super.key,
    required this.onChanged,
    required this.isHabitChecked,
    required this.habitText,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //Settings option
            SlidableAction(
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(16),
              onPressed: settingsTapped,
            ),

            //Delete option
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(16),
              onPressed: deleteTapped,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
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
      ),
    );
  }
}
