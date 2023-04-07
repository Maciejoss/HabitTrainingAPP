import 'package:habit_trainer/items/task.dart';
import 'package:habit_trainer/items/todo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Habit extends Task {
  String id;
  String name;
  String description;
  DateTime startDate;
  String category;
  bool mode;
  int frequency;
  List<int> areDone;

  Habit({
    required this.id,
    required this.name,
    this.description = "",
    required this.category,
    required this.startDate,
    required this.mode,
    required this.frequency,
    required this.areDone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'startDate': startDate,
        'mode': mode,
        'frequency': frequency,
        'areDone': areDone
      };

  static Habit fromJson(Map<String, dynamic> json) => Habit(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        category: json['category'],
        startDate: json['startDate'].toDate(),
        mode: json['mode'],
        frequency: json['frequency'],
        areDone: json['areDone'].cast<int>(),
      );

  static void fillHabit(Habit habit) {
    habit.startDate = DateTime(
        habit.startDate.year, habit.startDate.month, habit.startDate.day);
    DateTime curDate = DateTime.now();
    DateTime today = DateTime(curDate.year, curDate.month, curDate.day);
    int daysNumber = today
            .difference(DateTime(habit.startDate.year, habit.startDate.month,
                habit.startDate.day))
            .inDays +
        1;

    int daysDifference = daysNumber - habit.areDone.length;
    for (int i = 0; i < daysDifference; i++) {
      habit.areDone.add(0);
    }
  }

  Todo getTask() {
    return Todo(id: id, name: name, category: category, date: startDate);
  }

  static int? idAll = 7;

  static List<Habit> habitList = [];
}
