import 'package:flutter/material.dart';
import 'package:habit_tracker/components/dialog_box.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? controller;
  bool isHabitChecked = false;
  List habits = [
    ['Read your bible', false],
    ['Read good books', false],
  ];

  void onHabitPress(value, index) {
    setState(() {
      habits[index][1] = value;
    });
  }

  void onSave() {
    setState(() {});
  }

  void onCancel() {
    setState(() {});
    Navigator.pop(context);
  }

  void newHabit() {
    showDialog(
        context: context,
        builder: (context) => NewHabitDialog(
              onSave: onSave,
              onCancel: onCancel,
              controller: controller,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: newHabit,
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HabitTile(
            isHabitChecked: habits[index][1],
            onChanged: (value) => onHabitPress(value, index),
            habitText: habits[index][0],
          );
        },
      ),
    );
  }
}
