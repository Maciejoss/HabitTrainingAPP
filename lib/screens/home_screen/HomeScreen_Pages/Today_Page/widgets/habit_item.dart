import 'package:flutter/material.dart';
import 'package:habit_trainer/items/categories.dart';

import '../../../../../items/Habit.dart';

class HabitItem extends StatelessWidget {
  final Habit habit;
  final Function onHabitChange;
  final DateTime date;
  final int index;
  const HabitItem({
    super.key,
    required this.habit,
    required this.onHabitChange,
    required this.date,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: index < habit.areDone.length
          ? ListTile(
              onTap: () {
                onHabitChange(habit);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              tileColor: Colors.white,
              leading: Icon(
                  habit.areDone[index] == 1
                      ? Icons.check_box
                      : habit.areDone[index] == 0
                          ? Icons.check_box_outline_blank
                          : Icons.indeterminate_check_box_sharp,
                  color: habit.areDone[index] == 2
                      ? Colors.red
                      : habit.areDone[index] == 1
                          ? Colors.green
                          : Colors.blue),
              title: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      children: [
                        Text(
                          habit.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: habit.areDone[index] == 1
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Text(
                          habit.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 77, 77, 77),
                            decoration: habit.areDone[index] == 1
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Categories.getIcon(habit.category)),
                ],
              ),
              trailing: Text(
                "habit",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListTile(
              onTap: () {
                onHabitChange(habit);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              tileColor: Colors.white,
              leading: Icon(Icons.check_box_outline_blank, color: Colors.blue),
              title: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      children: [
                        Text(
                          habit.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: null,
                          ),
                        ),
                        Text(
                          habit.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 77, 77, 77),
                            decoration: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Categories.getIcon(habit.category)),
                ],
              ),
              trailing: Text(
                "habit",
                style: TextStyle(color: Colors.grey),
              ),
            ),
    );
  }
}
