import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference the box
final _mybox = Hive.box("Habit_Database");

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

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

    // Calculate habit complete percentage for each day
    calculateHabitPercentages();

    // load heat map
    loadHeatMap();
  }

  // Calculate habit complete percentage for each day
  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    // Key "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0.0-1.0 inclusive
    _mybox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  // load heat map
  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_mybox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from the start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key of the database
    for (int i = 0; i < daysInBetween; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strength = double.parse(
        _mybox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      //split the datetime up like below so it doesn't worry about hours/mins/secs etc

      //year
      int year = startDate.add(Duration(days: i)).year;

      //month
      int month = startDate.add(Duration(days: i)).month;

      //days
      int day = startDate.add(Duration(days: i)).day;

      final percentageForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strength.toInt()),
      };

      heatMapDataSet.addEntries(percentageForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
