import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:habit_trainer/Services/habits_manage_service.dart';

import '../../../items/Habit.dart';
import '../EventStates/event_states.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({super.key, required this.habit}) {
    markedDateMap = EventStates.initializeCalendar(habit);
  }

  bool isChecked = false;
  final Habit habit;
  late EventList<Event> markedDateMap;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: CalendarCarousel(
              onDayPressed: widget.isChecked ? _changeDayMark : (p0, p1) => {},
              markedDatesMap: widget.markedDateMap,
              todayButtonColor: Colors.transparent,
              prevDaysTextStyle: const TextStyle(
                color: Colors.grey,
              ),
              nextDaysTextStyle: const TextStyle(
                color: Colors.grey,
              ),
              firstDayOfWeek: 1,
              weekdayTextStyle: const TextStyle(color: Colors.grey),
              daysTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              weekendTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Enable editting"),
              Checkbox(
                checkColor: Colors.white,
                value: widget.isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    widget.isChecked = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _changeDayMark(DateTime date, List<Event> events) {
    if (widget.markedDateMap.events.containsKey(date)) {
      setState(() {
        int dif = date.difference(widget.habit.startDate).inDays;
        int newValue = widget.habit.areDone[dif] + 1;
        if (newValue == 3) newValue = 0;
        widget.habit.areDone[dif] = newValue;
        HabitsManageService.updateHabitState(widget.habit);
        widget.markedDateMap.events
            .update(date, (value) => [_getNextState(events[0])]);
      });
    }
  }

  Event _getNextState(Event e) {
    String newTitle = e.title == "inprogres"
        ? "done"
        : e.title == "done"
            ? "notdone"
            : "inprogres";
    return EventStates.event[newTitle]!;
  }
}
