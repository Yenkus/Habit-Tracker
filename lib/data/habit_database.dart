import 'package:habit_tracker/datatime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference the box
final _mybox = Hive.box("Habit_Database");

class HabitDatabase {
  List todaysHabitList = [];

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      ['Read your bible', false],
      ['Exercise your body', false],
    ];

    // save the start date
    _mybox.put('START_DATE', todaysDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get habit list from database
    if (_mybox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _mybox.get('CURRENT_HABIT_LIST');

      // set all habit completed to false since it's a new day
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    // if it's not a new day, load todays list
    else {
      todaysHabitList = _mybox.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    // update todays entry
    _mybox.put(todaysDateFormatted(), todaysHabitList);

    // update universal habit list in case it changed (new habit, edit habit, delete habit)
    _mybox.put('CURRENT_HABIT_LIST', todaysHabitList);
  }
}
