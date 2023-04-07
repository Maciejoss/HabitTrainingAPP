// ignore: file_names
import 'package:flutter/material.dart';
import 'package:habit_trainer/screens/add_task_screen/add_task_screen.dart';
import '../../add_habit_screen/add_habit_screen.dart';

enum _MenuValues { addTask, addHabit }

class AddButton extends StatefulWidget {
  final Function callbackTodo;
  final Function callbackHabit;
  const AddButton(this.callbackTodo, this.callbackHabit, {super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuValues>(
        offset: const Offset(0, -20),
        itemBuilder: (BuildContext context) => const [
              PopupMenuItem(
                value: _MenuValues.addTask,
                child: Text("Add Todo item"),
              ),
              PopupMenuItem(
                value: _MenuValues.addHabit,
                child: Text("Add Habit"),
              )
            ],
        onSelected: (value) async {
          switch (value) {
            case _MenuValues.addTask:
              {
                final t = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                );
                if (t != null) {
                  widget.callbackTodo(t);
                }
              }
              break;
            case _MenuValues.addHabit:
              final t = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddHabitScreen()));
              if (t != null) {
                widget.callbackHabit(t);
              }
              break;
          }
        });
  }
}
