// ignore: file_names
import 'package:flutter/material.dart';
import 'navigation_bar_item.dart';

class Nam extends StatefulWidget {
  const Nam({super.key, required this.maciek});

  final int maciek;

  @override
  State<Nam> createState() => _NamState();
}

class _NamState extends State<Nam> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.onItemSelected,
  });

  final ValueChanged<int> onItemSelected;

  @override
  State<MyBottomNavigationBar> createState() => MyBottomNavigationBartate();
}

class MyBottomNavigationBartate extends State<MyBottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            right: 8,
            left: 8,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                lable: 'Today',
                icon: Icons.calendar_today,
                index: 0,
                isSelected: (selectedIndex == 0),
                onTap: handleItemSelected,
              ),
              NavigationBarItem(
                lable: 'Habits',
                icon: Icons.calendar_today,
                index: 1,
                isSelected: (selectedIndex == 1),
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
