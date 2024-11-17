import 'package:flutter/material.dart';

class ColorUtility {
  static Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return const Color.fromARGB(255, 255, 204, 0);
      case 'orange':
        return const Color.fromARGB(255, 255, 98, 0);
      case 'green':
        return const Color.fromARGB(255, 33, 148, 37);
      default:
        return const Color.fromARGB(255, 37, 117, 255);
    }
  }

  static Color getPriorityColor(int? priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
