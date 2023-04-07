// ignore: file_names
import 'package:flutter/material.dart';
import 'package:habit_trainer/items/Habit.dart';
import 'package:uuid/uuid.dart';

import '../../Services/habits_manage_service.dart';
import '../../shared_widgets/category_dialog_widget.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final frequencyController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  DateTime date = DateTime.now();
  String category = "Sport";

  bool isToday(DateTime d1) {
    DateTime d2 = DateTime.now();
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @override
  Widget build(BuildContext context) {
    frequencyController.text = "1";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Habit screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              controller: nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  labelText: 'Habit Name', border: OutlineInputBorder()),
              validator: (name) =>
                  name != null && name.isEmpty ? 'Enter a name' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  labelText: 'Habit Description', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                isToday(date)
                    ? const Text('Today')
                    : Text('${date.year}/${date.month}/${date.day}'),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 30),
                    backgroundColor: Colors.blue.withOpacity(0.3),
                  ),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                    });
                  },
                  child: const Text('Select starting date'),
                ),
              ],
            ),
            Row(
              children: [
                Text(category),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 30),
                      backgroundColor: Colors.blue.withOpacity(0.3),
                    ),
                    onPressed: () async {
                      final choosenCategory = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CategoryDialogWidget();
                          });
                      if (choosenCategory != null) {
                        setState(() {
                          category = choosenCategory;
                        });
                      }
                    },
                    child: const Text('Choose Category')),
              ],
            ),
            Row(
              children: [
                const Text('Every   '),
                SizedBox(
                  width: 40,
                  height: 30,
                  child: TextFormField(
                    controller: frequencyController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Text('   Days'),
              ],
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: handleAddHabit, child: const Text("Add Habit"))
          ]),
        ),
      ),
    );
  }

  handleAddHabit() async {
    if (!formKey.currentState!.validate()) return;
    var uuid = const Uuid();
    var td = Habit(
      id: uuid.v4(),
      name: nameController.text,
      description: descController.text,
      category: category,
      startDate: DateTime(date.year, date.month, date.day),
      mode: false,
      frequency: int.parse(frequencyController.text),
      areDone: [0],
    );
    Habit.fillHabit(td);
    await addHabit(habit: td);
  }

  Future addHabit({required Habit habit}) async {
    HabitsManageService.addHabit(habit);
    Navigator.pop(context, habit);
  }
}
