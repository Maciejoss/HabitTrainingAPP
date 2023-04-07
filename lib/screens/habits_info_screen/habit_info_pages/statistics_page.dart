import 'package:flutter/material.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/Widgets/column_chart/column_chart.dart';
import 'package:habit_trainer/screens/habits_info_screen/habit_info_pages/Widgets/column_chart/Widgets/month_carousel.dart';

import '../../../items/Habit.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({super.key, required this.habit});

  final Habit habit;
  int month = DateTime.now().month;

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    int score = countScore(widget.habit);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("Habit Score"),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(children: <Widget>[
              TweenAnimationBuilder<double>(
                curve: Curves.ease,
                tween: Tween<double>(begin: 0.0, end: score / 100),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, _) => SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 20,
                    )),
              ),
              Center(
                child: TweenAnimationBuilder(
                  curve: Curves.ease,
                  tween: IntTween(begin: 0, end: score),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, _) => Text(value.toString()),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text("Habit preformance diagram"),
          const SizedBox(
            height: 10,
          ),
          ColumnChart(
            habit: widget.habit,
          ),
        ],
      ),
    );
  }

  int countScore(Habit habit) {
    int success = habit.areDone.where((element) => element == 1).length;
    return (100 * success / habit.areDone.length).round();
  }
}
