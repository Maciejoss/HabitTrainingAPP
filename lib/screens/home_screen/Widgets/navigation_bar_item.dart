// ignore: file_names
import 'package:flutter/material.dart';
import '../../../themes.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.lable,
    required this.icon,
    required this.index,
    required this.onTap,
    this.isSelected = false,
  });

  final int index;
  final String lable;
  final IconData icon;
  final ValueChanged<int> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: AppColors.secondary,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 25,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.secondary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
