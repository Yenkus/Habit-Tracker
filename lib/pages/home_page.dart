import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _newHabitNameController = TextEditingController();
  bool isHabitChecked = false;
  List todaysHabitList = [
    ['Read your bible', false],
    ['Read good books', false],
  ];

  void onHabitPress(value, index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  // Add new habit
  void onSave() {
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
  }

  // cancel dialog box
  void cancelDialogBox() {
    Navigator.pop(context);
    _newHabitNameController.clear();
  }

  // Create new habit
  void createNewHabit() {
    // Show alert dialog
    showDialog(
        context: context,
        builder: (context) => MyAlertBox(
              onSave: onSave,
              onCancel: cancelDialogBox,
              controller: _newHabitNameController,
              hintText: 'Enter habit name..',
            ));
  }

  // open habit settings to edit
  void openHabitSetting(int index) {
    showDialog(
        context: context,
        builder: (context) => MyAlertBox(
              controller: _newHabitNameController,
              onSave: () => saveExistingHabit(index),
              onCancel: cancelDialogBox,
              hintText: todaysHabitList[index][0],
            ));
  }

  //save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            isHabitChecked: todaysHabitList[index][1],
            onChanged: (value) => onHabitPress(value, index),
            habitText: todaysHabitList[index][0],
            settingsTapped: (context) => openHabitSetting(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
