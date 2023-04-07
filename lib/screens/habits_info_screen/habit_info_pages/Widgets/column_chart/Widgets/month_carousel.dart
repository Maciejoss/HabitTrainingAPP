import 'dart:developer';

import 'package:flutter/material.dart';

class MonthCarousel extends StatefulWidget {
  final Function onChange;
  MonthCarousel({super.key, required this.onChange});

  @override
  State<MonthCarousel> createState() => _MonthCarouselState();
}

class _MonthCarouselState extends State<MonthCarousel> {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  int month = DateTime.now().month;
  int year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onTap: (() {
          setState(() {
            month = month - 1;
            if (month == 0) {
              year--;
              month = 12;
            }
          });
          widget.onChange(year, month);
        }),
        child:
            const SizedBox(child: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      Spacer(),
      Text(months[month - 1] + " " + year.toString()),
      Spacer(),
      GestureDetector(
        onTap: (() {
          setState(() {
            month++;
            if (month == 13) {
              month = 1;
              year++;
            }
          });
          widget.onChange(year, month);
        }),
        child: const Icon(Icons.arrow_forward_ios_sharp),
      )
    ]);
  }
}
