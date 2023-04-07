import 'package:flutter/material.dart';

class NameEditPopup extends StatefulWidget {
  const NameEditPopup({super.key});

  @override
  State<NameEditPopup> createState() => _NameEditPopupState();
}

class _NameEditPopupState extends State<NameEditPopup> {
  @override
  Widget build(BuildContext context) {
    final textController = new TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
              child: Text('Type new name'),
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                      labelText: 'Habit Name', border: OutlineInputBorder()),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(children: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.pop(context, textController.text);
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
