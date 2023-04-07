import 'package:flutter/material.dart';
import 'package:habit_trainer/Services/todos_manage_service.dart';
import 'package:habit_trainer/shared_widgets/category_dialog_widget.dart';
import 'package:uuid/uuid.dart';

import '../../items/todo.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Task screen'),
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
                  labelText: 'Task Name', border: OutlineInputBorder()),
              validator: (name) =>
                  name != null && name.isEmpty ? 'Enter a name' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  labelText: 'Task Description', border: OutlineInputBorder()),
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
                    fixedSize: const Size(150, 30),
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
                  child: const Text('Select date'),
                ),
              ],
            ),
            Row(
              children: [
                Text(category),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 30),
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
            const Spacer(),
            ElevatedButton(
                onPressed: handleAddTask, child: const Text("Add task"))
          ]),
        ),
      ),
    );
  }

  handleAddTask() async {
    if (!formKey.currentState!.validate()) return;
    var uuid = const Uuid();
    var td = Todo(
      id: uuid.v4(),
      name: nameController.text,
      description: descController.text,
      category: category,
      date: date,
      isDone: false,
    );
    await addTask(task: td);
  }

  Future addTask({required Todo task}) async {
    TodosManageService.addTask(task);
    Navigator.pop(context, task);
  }
}
