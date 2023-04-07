import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DaysSlider extends StatefulWidget {
  final Function changeDate;
  const DaysSlider({super.key, required this.changeDate});

  @override
  State<DaysSlider> createState() => _DaysSliderState();
}

class _DaysSliderState extends State<DaysSlider> {
  DateTime today = DateTime.now();
  int choosenIndex = 30;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ScrollablePositionedList.builder(
        itemCount: 60,
        scrollDirection: Axis.horizontal,
        initialScrollIndex: choosenIndex,
        initialAlignment: 0.5,
        itemBuilder: (BuildContext context, int index) {
          DateTime date = today.add(Duration(days: index - 30));
          return GestureDetector(
            onTap: () {
              widget.changeDate(date);
              setState(() {
                choosenIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                color: index != choosenIndex ? Colors.black : Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('E').format(date),
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        date.day.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
