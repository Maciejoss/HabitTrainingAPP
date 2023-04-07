import 'package:flutter/material.dart';
import 'package:habit_trainer/items/Habit.dart';
import 'package:habit_trainer/screens/home_screen/HomeScreen_Pages/Habits_Page/habits_page.dart';
import 'package:habit_trainer/screens/home_screen/HomeScreen_Pages/Today_Page/today_page.dart';

import '../../Services/habits_manage_service.dart';
import '../../Services/todos_manage_service.dart';
import '../../items/todo.dart';
import 'Widgets/add_button.dart';
import 'Widgets/bottom_navigation_bar.dart';
import 'Widgets/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Days');
  int count = 5;

  final pageTitles = const [
    'Days',
    'Habits',
    'Calls',
    'Contacts',
  ];

  void onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  void callbackTodo(Todo task) {
    setState(() {
      Todo.todoList.add(task);
      count++;
    });
  }

  void callbackHabit(Habit habit) {
    setState(() {
      Habit.habitList.add(habit);
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      TodayPage(
        key: ValueKey(count),
      ),
      HabitsPage(
        key: ValueKey(count),
      ),
    ];

    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              drawer: const NavigationDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: ValueListenableBuilder(
                  valueListenable: title,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 24),
                  )
                ],
              ),
              body: ValueListenableBuilder(
                valueListenable: pageIndex,
                builder: (BuildContext context, int value, _) {
                  return pages[value];
                },
              ),
              bottomNavigationBar: MyBottomNavigationBar(
                onItemSelected: onNavigationItemSelected,
              ),
              floatingActionButton: AddButton(callbackTodo, callbackHabit),
            );
          }
        });
  }

  Future<String> loadData() async {
    Todo.todoList = await TodosManageService.readTodos();
    Habit.habitList = await HabitsManageService.readHabits();
    for (Habit h in Habit.habitList) {
      Habit.fillHabit(h);
    }
    return "loaded";
  }
}
