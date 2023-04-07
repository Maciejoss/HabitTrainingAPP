import 'package:habit_trainer/items/task.dart';

class Todo extends Task {
  String id;
  String name;
  String description;
  DateTime date;
  String category;
  bool isDone;

  Todo({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    this.description = "",
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'isDone': isDone,
        'date': date,
      };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      isDone: json['isDone'],
      date: json['date'].toDate());

  static int? idAll = 7;

  static List<Todo> todoList = [];
}
