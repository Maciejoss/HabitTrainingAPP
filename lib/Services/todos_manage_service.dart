// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import '../items/todo.dart';

class TodosManageService {
  static bool serviceOn = true;

  static Future<List<Todo>> readTodos() async {
    var snapshot = await FirebaseFirestore.instance.collection('todos').get();
    return snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
  }

  static void changeTaskState(String id, bool state) {
    if (!serviceOn) return;
    final docTodo = FirebaseFirestore.instance.collection('todos').doc(id);
    docTodo.update({'isDone': state});
  }

  static void deleteTask(String id) {
    if (!serviceOn) return;
    final docTodo = FirebaseFirestore.instance.collection('todos').doc(id);
    docTodo.delete();
  }

  static void addTask(Todo task) {
    if (!serviceOn) return;
    final docToDo = FirebaseFirestore.instance.collection('todos').doc(task.id);
    docToDo.set(task.toJson());
  }
}
