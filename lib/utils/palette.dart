import 'package:flutter/material.dart';

class Palette {
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }

  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).disabledColor;
  }

  static Color getContrastColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.grey.shade700;
  }
}
