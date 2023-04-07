import 'package:flutter/material.dart';

class DeleteItemConfirmDialog extends StatelessWidget {
  const DeleteItemConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            const Text('Are you sure, you want to delete this task?'),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Cancel')),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: const Text('Delete'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
