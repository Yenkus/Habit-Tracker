import 'package:flutter/material.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _newHabitNameController = TextEditingController();
  bool isHabitChecked = false;
  HabitDatabase db = HabitDatabase();
  final _mybox = Hive.box('Habit_Database');

  @override
  void initState() {
    super.initState();
    // if there is no current habit list,
    // then this is the 1st time ever opening the app
    // then create dafault data
    if (_mybox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // there already exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();
  }

  void onHabitPress(value, index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
  }

  // Add new habit
  void onSave() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
    // update the database
    db.updateDatabase();
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
              hintText: db.todaysHabitList[index][0],
            ));
  }

  //save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
    // update the database
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    // update the database
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        body: ListView(
          children: [
            // Monthly summary heat map
            MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _mybox.get('START_DATE')),

            // Lists of habits
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  isHabitChecked: db.todaysHabitList[index][1],
                  onChanged: (value) => onHabitPress(value, index),
                  habitText: db.todaysHabitList[index][0],
                  settingsTapped: (context) => openHabitSetting(index),
                  deleteTapped: (context) => deleteHabit(index),
                );
              },
            ),
          ],
        ));
  }
}
