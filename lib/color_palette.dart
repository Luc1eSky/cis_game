import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPalette {
  // general colors
  Color get backgroundColor => const Color.fromRGBO(180, 215, 157, 1.0);
  Color get dialogBackgroundColor => const Color.fromRGBO(190, 222, 231, 1.0);
  Color get tileColor => const Color.fromRGBO(161, 160, 153, 0.5);
  Color get plantButton => const Color.fromRGBO(33, 155, 3, 1.0);
// plus minus button
  Color get plusMinusButtonColor => const Color.fromRGBO(255, 255, 255, 1.0);
  Color get iconColor => const Color.fromRGBO(0, 0, 0, 1.0);
// field section colors
  Color get fieldBackground => const Color.fromRGBO(206, 149, 41, 1.0);
  Color get fieldColorEmpty => const Color.fromRGBO(155, 95, 32, 1.0);
  Color get fieldColorSeeded => const Color.fromRGBO(155, 95, 32, 1.0);
  Color get fieldColorHarvested => const Color.fromRGBO(155, 95, 32, 1.0);
// seed legend color
  Color get seedEarlyMaturing => const Color.fromRGBO(227, 7, 7, 1.0);
  Color get seedNormalMaturing => const Color.fromRGBO(7, 143, 227, 1.0);
  Color get seedNormalMaturingHighYield =>
      const Color.fromRGBO(119, 28, 217, 1.0);
  Color get snackBar => const Color.fromRGBO(40, 157, 231, 1.0);
}
