import 'package:flutter/material.dart';
import 'package:habit_trainer/items/Habit.dart';
import 'package:habit_trainer/screens/home_screen/HomeScreen_Pages/Habits_Page/Widgets/habit_item.dart';
import 'package:unicons/unicons.dart';

import '../../../../Services/habits_manage_service.dart';
import '../../../../items/Habit.dart';

class HabitsPage extends StatefulWidget {
  int counter = 0;
  HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  void onComeBack() {
    setState(() {
      widget.counter++;
    });
  }

  onHabitDelete(String id) {
    setState(() {
      Habit.habitList.removeWhere((element) => element.id == id);
      HabitsManageService.deleteHabit(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var habits = Habit.habitList;
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        if (habits.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: const [
                  Text(
                    'No habits yet',
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    UniconsLine.bed,
                    size: 100,
                  )
                ],
              ),
            ),
          )
        else
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              for (Habit habit in habits)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HabitItem(
                    habit: habit,
                    callback: onComeBack,
                    deleteCallback: onHabitDelete,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
