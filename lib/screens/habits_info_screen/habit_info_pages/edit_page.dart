import 'package:flutter/material.dart';
import 'package:habit_trainer/Services/habits_manage_service.dart';
import 'package:habit_trainer/items/categories.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/Widgets/popups/description_edit_popup.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/Widgets/popups/name_edit_popup.dart';
import 'package:unicons/unicons.dart';

import '../../../items/Habit.dart';
import '../../../shared_widgets/category_dialog_widget.dart';
import '../../../shared_widgets/delete_item_confirm_dialog.dart';

class EDitPage extends StatefulWidget {
  final Habit habit;
  final Function callback;
  const EDitPage({super.key, required this.habit, required this.callback});

  @override
  State<EDitPage> createState() => _EDitPageState();
}

class _EDitPageState extends State<EDitPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Divider(),
        ListTile(
          onTap: () async {
            final newName = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NameEditPopup();
                });
            if (newName != null) {
              widget.callback(newName);
            }
          },
          leading: Text("Name"),
          trailing: Text(widget.habit.name),
        ),
        Divider(),
        ListTile(
          onTap: () async {
            final newDesc = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DescriptionEditPopup();
                });
            if (newDesc != null) {
              setState(() {
                widget.habit.description = newDesc;
              });
            }
          },
          leading: Text("Description"),
          trailing: SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(widget.habit.description)),
            ),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () async {
            final choosenCategory = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CategoryDialogWidget();
                });
            if (choosenCategory != null) {
              setState(() {
                widget.habit.category = choosenCategory;
              });
            }
          },
          leading: Text("Category"),
          trailing: SizedBox(
            width: 100,
            child: Row(children: [
              Text(widget.habit.category),
              Spacer(),
              Icon(
                Categories.getIcon(widget.habit.category),
              ),
            ]),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: widget.habit.startDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            setState(() {
              //widget.habit.startDate = newDate;
            });
          },
          leading: Text("Start Date"),
          trailing: Text(
              '${widget.habit.startDate.year}/${widget.habit.startDate.month}/${widget.habit.startDate.day}'),
        ),
        Divider(),
        ListTile(
          onTap: () async {
            final confirmDelete = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const DeleteItemConfirmDialog();
              },
            );
            if (confirmDelete != null && confirmDelete) {
              HabitsManageService.deleteHabit(widget.habit.id);
              Habit.habitList
                  .removeWhere((element) => element.id == widget.habit.id);
              Navigator.pop(context);
            }
          },
          leading: SizedBox(
            width: 200,
            child: Row(
              children: [
                Icon(UniconsLine.trash),
                SizedBox(
                  width: 20,
                ),
                Text("Delete Habit"),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
