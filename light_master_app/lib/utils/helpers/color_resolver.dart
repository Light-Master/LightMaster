import 'dart:ui';

import 'package:flutter/material.dart';

class ColorResolver {
  static resolveTextForegroundColor(Color backgroundColor) {
    bool darkColor =
        backgroundColor.red + backgroundColor.blue + backgroundColor.green >=
            370;
    return darkColor ? Colors.black : Colors.white;
  }
}
