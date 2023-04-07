import 'package:flutter/material.dart';
import 'package:habit_trainer/Services/habits_manage_service.dart';
import 'package:habit_trainer/items/categories.dart';
import 'package:habit_trainer/screens/habits_info_screen/habits_info_screen.dart';
import 'package:unicons/unicons.dart';

import '../../../../../items/Habit.dart';
import '../../../../../shared_widgets/delete_item_confirm_dialog.dart';

class HabitItem extends StatelessWidget {
  final Habit habit;
  final Function callback;
  final Function deleteCallback;

  const HabitItem({
    super.key,
    required this.habit,
    required this.callback,
    required this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    habit.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  habit.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 77, 77, 77),
                  ),
                ),
                Icon(Categories.getIcon(habit.category)),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HabitsInfoScreen(
                                habit: habit,
                                page: 0,
                              )),
                    );
                    callback();
                  },
                  icon: const Icon(UniconsLine.calendar_alt),
                  label: const Text(''),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HabitsInfoScreen(
                                habit: habit,
                                page: 1,
                              )),
                    );
                    callback();
                  },
                  icon: const Icon(UniconsLine.chart),
                  label: const Text(''),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HabitsInfoScreen(
                                habit: habit,
                                page: 2,
                              )),
                    );
                    callback();
                  },
                  icon: const Icon(UniconsLine.edit),
                  label: const Text(''),
                )
              ],
            )
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmDelete = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const DeleteItemConfirmDialog();
                },
              );
              if (confirmDelete != null && confirmDelete) {
                deleteCallback(habit.id);
              }
            },
          ),
        ),
      ),
    );
  }
}
