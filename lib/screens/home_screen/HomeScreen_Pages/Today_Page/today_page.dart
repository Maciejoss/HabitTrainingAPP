import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:habit_trainer/Services/habits_manage_service.dart';
import 'package:habit_trainer/Services/todos_manage_service.dart';
import 'package:habit_trainer/items/Habit.dart';
import 'package:habit_trainer/items/task.dart';
import 'package:habit_trainer/shared_widgets/delete_item_confirm_dialog.dart';
import '../../../../items/items.dart';
import '../../../../widgets/widgets.dart';
import 'widgets/days_slider.dart';
import 'package:unicons/unicons.dart';

import 'widgets/habit_item.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => TodayPageState();
}

class TodayPageState extends State<TodayPage> {
  late List<Task> todayTodos;
  late List<Habit> habits;
  DateTime choosenDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    choosenDate = choosenDate;
    todayTodos = _getTodayTasks();

    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: DaysSlider(changeDate: _handleDayChange),
        ),
        if (todayTodos.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: const [
                  Text(
                    'No tasks for today :)',
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
              for (Task todo in todayTodos)
                if (todo is Todo)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ToDoItem(
                      todo: todo,
                      onTodoChange: _handleTodoChange,
                      onDelete: _handleDeletion,
                    ),
                  ),
              for (Task todo in todayTodos)
                if (todo is Habit)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: HabitItem(
                        habit: todo,
                        onHabitChange: _handleHabitChange,
                        date: choosenDate,
                        index: choosenDate.difference(todo.startDate).inDays),
                  )
            ],
          ),
      ],
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;

      TodosManageService.changeTaskState(todo.id, todo.isDone);
    });
  }

  void _handleHabitChange(Habit habit) {
    setState(() {
      DateTime now = DateTime.now();
      DateTime nowDate = DateTime(now.year, now.month, now.day);
      if (choosenDate.isAfter(nowDate)) {
        return;
      }
      int index = choosenDate.difference(habit.startDate).inDays;
      setState(() {
        habit.areDone[index]++;
      });

      if (habit.areDone[index] == 3) habit.areDone[index] = 0;
      HabitsManageService.updateHabitState(habit);
    });
  }

  void _handleDeletion(String id) async {
    final confirmDelete = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const DeleteItemConfirmDialog();
      },
    );

    if (confirmDelete) {
      setState(() {
        Todo.todoList.removeWhere((element) => element.id == id);
        TodosManageService.deleteTask(id);
      });
    }
  }

  void _handleDayChange(DateTime index) {
    setState(() {
      choosenDate = DateTime(index.year, index.month, index.day);
    });
  }

  List<Task> _getTodayTasks() {
    List<Task> newList = List<Task>.empty(growable: true);
    for (var todo in Todo.todoList) {
      if (todo.date.day == choosenDate.day &&
          todo.date.month == choosenDate.month) {
        newList.add(todo);
      }
    }
    for (Habit habit in Habit.habitList) {
      if (habit.startDate.isBefore(choosenDate.add(const Duration(days: 1)))) {
        newList.add(habit);
      }
    }
    return newList;
  }
}
