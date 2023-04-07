import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../items/Habit.dart';
import 'Widgets/month_carousel.dart';

class ColumnChart extends StatefulWidget {
  final Habit habit;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int monthDays = DateTime(2023, DateTime.now().month + 1, 0).day;
  int skip = 15;

  ColumnChart({super.key, required this.habit});

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  @override
  Widget build(BuildContext context) {
    changeMonth(widget.year, widget.month);
    final List<ChartData> chartData =
        _getChartDataFromHabit(widget.habit, widget.skip);

    return Column(children: [
      MonthCarousel(
        onChange: changeMonth,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: widget.monthDays * 20,
          height: 250,
          child: SfCartesianChart(
            borderWidth: 2,
            plotAreaBorderWidth: 0,
            // Initialize category axis
            primaryXAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 2),
              minimum: 1,
              interval: 1,
              maximum: widget.monthDays.toDouble(),
            ),
            primaryYAxis: NumericAxis(
              isVisible: false,
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              minimum: 0,
              interval: 1,
              maximum: 1,
            ),
            series: <ChartSeries<ChartData, int>>[
              // Renders column chart
              ColumnSeries<ChartData, int>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
            ],
          ),
        ),
      ),
    ]);
  }

  List<ChartData> _getChartDataFromHabit(Habit habit, int skip) {
    List<ChartData> chartData = [];
    if (skip < 1) return chartData;
    for (int i = widget.monthDays; i > 0; i--) {
      int index = skip - i + 1;
      if (index >= habit.areDone.length) continue;
      if (index < 0) continue;
      chartData.add(ChartData(widget.monthDays - (skip - (index)),
          habit.areDone[index] == 1 ? 1 : 0));
    }
    return chartData;
  }

  void changeMonth(int newyear, int newMonth) {
    int dif =
        DateTime(newyear, newMonth, DateTime(newyear, newMonth + 1, 0).day)
            .difference(widget.habit.startDate)
            .inDays;
    setState(() {
      widget.month = newMonth;
      widget.year = newyear;
      widget.monthDays = DateTime(newyear, widget.month + 1, 0).day;
      widget.skip = dif;
    });
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}
