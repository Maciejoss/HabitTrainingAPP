import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import '../../../items/Habit.dart';

class EventStates {
  static Map<String, Event> event = {
    "notdone": Event(
      date: DateTime(2023, 1, 20),
      title: 'notdone',
      dot: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.red,
          ),
          shape: BoxShape.circle,
        ),
      ),
    ),
    "inprogres": Event(
      date: DateTime(2023, 1, 20),
      title: 'inprogres',
      dot: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.blue,
          ),
          shape: BoxShape.circle,
        ),
      ),
    ),
    "done": Event(
      date: DateTime(2023, 1, 20),
      title: 'done',
      dot: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.green,
          ),
          shape: BoxShape.circle,
        ),
      ),
    ),
  };

  static Map<int, String> state = {
    0: "inprogres",
    1: "done",
    2: "notdone",
  };

  static EventList<Event> initializeCalendar(Habit habit) {
    int diff = DateTime.now().difference(habit.startDate).inDays;

    Map<DateTime, List<Event>> events = <DateTime, List<Event>>{};

    for (int i = 0; i <= diff; i++) {
      events[habit.startDate.add(Duration(days: i))] = [
        EventStates.event[state[habit.areDone[i]]]!
      ];
    }

    return EventList<Event>(
      events: events,
    );
  }
}
