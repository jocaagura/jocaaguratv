import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get darkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  TextStyle? get titleSmall {
    return Theme.of(this).textTheme.titleSmall;
  }
}
