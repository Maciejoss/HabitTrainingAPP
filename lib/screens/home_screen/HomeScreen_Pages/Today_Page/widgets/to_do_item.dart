import 'package:flutter/material.dart';
import 'package:habit_trainer/items/categories.dart';
import 'package:habit_trainer/items/items.dart';

class ToDoItem extends StatelessWidget {
  final Todo todo;
  final Function onTodoChange;
  final Function onDelete;

  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onTodoChange,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Row(
          children: [
            SizedBox(
              width: 150,
              child: Column(
                children: [
                  Text(
                    todo.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    todo.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 77, 77, 77),
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Icon(Categories.getIcon(todo.category)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
