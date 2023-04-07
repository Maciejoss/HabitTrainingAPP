import 'package:flutter/material.dart';

class Categories {
  static List<String> categoryTypes = ['Sport', 'Cleaning', 'Work', 'Study'];

  static IconData getIcon(String desc) {
    switch (desc) {
      case 'Sport':
        return Icons.sports_gymnastics;
      case 'Cleaning':
        return Icons.cleaning_services;
      case 'Wrok':
        return Icons.work;
      case 'Study':
        return Icons.book;
    }
    return Icons.task;
  }
}
