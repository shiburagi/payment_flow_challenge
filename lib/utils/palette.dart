import 'package:flutter/material.dart';

class Palette {
  static getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }

  static getDividerColor(BuildContext context) {
    return Theme.of(context).disabledColor;
  }

  static getContrastColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.grey.shade700;
  }
}
