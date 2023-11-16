import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          // HabitTile(isHabitChecked: false, onChanged: (bool? ) {},),
        ],
      ),
    );
  }
}
