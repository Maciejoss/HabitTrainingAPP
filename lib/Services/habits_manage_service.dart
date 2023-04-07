// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import '../items/Habit.dart';

class HabitsManageService {
  static Future<List<Habit>> readHabits() async {
    var snapshot = await FirebaseFirestore.instance.collection('habits').get();
    return snapshot.docs.map((doc) => Habit.fromJson(doc.data())).toList();
  }

  static void updateHabitState(Habit habit) {
    final docHabit =
        FirebaseFirestore.instance.collection('habits').doc(habit.id);
    docHabit.update({'areDone': habit.areDone});
  }

  static void deleteHabit(String id) async {
    final docHabit = FirebaseFirestore.instance.collection('habits').doc(id);
    docHabit.delete();
  }

  static void addHabit(Habit habit) {
    final docHabit =
        FirebaseFirestore.instance.collection('habits').doc(habit.id);
    docHabit.set(habit.toJson());
  }
}
