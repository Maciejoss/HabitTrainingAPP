import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:habit_trainer/screens/habits_info_screen/EventStates/event_states.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/calendar_page.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/edit_page.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/statistics_page.dart';

import '../../items/Habit.dart';

class HabitsInfoScreen extends StatefulWidget {
  final Habit habit;
  final int page;
  HabitsInfoScreen({super.key, required this.habit, required this.page}) {
    markedDateMap = EventStates.initializeCalendar(habit);
  }

  late EventList<Event> markedDateMap;
  bool isChecked = false;

  @override
  State<HabitsInfoScreen> createState() => HabitsInfoScreenState();
}

class HabitsInfoScreenState extends State<HabitsInfoScreen> {
  onNamechanged(String newName) {
    setState(() {
      widget.habit.name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.page,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.habit.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'callendar'),
              Tab(text: 'statistics'),
              Tab(text: 'edit'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              CalendarPage(
                habit: widget.habit,
              ),
              StatisticsPage(
                habit: widget.habit,
              ),
              EDitPage(
                habit: widget.habit,
                callback: onNamechanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
