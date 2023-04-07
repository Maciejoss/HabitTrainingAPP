// ignore: file_names
import 'package:flutter/material.dart';
import '../items/categories.dart';

class CategoryDialogWidget extends StatefulWidget {
  const CategoryDialogWidget({super.key});

  @override
  State<CategoryDialogWidget> createState() => _CategoryDialogWidgetState();
}

class _CategoryDialogWidgetState extends State<CategoryDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
              child: Text('Choose category'),
            ),
            Container(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal:
                      BorderSide(color: Color.fromARGB(255, 92, 95, 123)),
                ),
              ),
              child: SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Wrap(
                      spacing: 50,
                      runSpacing: 40,
                      direction: Axis.horizontal,
                      children: [
                        for (String category in Categories.categoryTypes)
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, category);
                            },
                            child: SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Icon(Categories.getIcon(category))
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
