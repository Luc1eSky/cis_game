import 'package:cis_game/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class ContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Dots(bgColor: ColorPalette().fieldColorEmpty, fgColor: Colors.brown)
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
