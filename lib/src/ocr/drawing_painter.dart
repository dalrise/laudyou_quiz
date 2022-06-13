import 'package:flutter/material.dart';

import 'constants.dart';

class DrawingPainter extends CustomPainter {
  DrawingPainter({required this.offsetPoints, required this.drawingPaint});
  final List<Offset?> offsetPoints;
  final Paint? drawingPaint;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < offsetPoints.length - 1; i++) {
      if (offsetPoints[i] != null && offsetPoints[i + 1] != null) {
        canvas.drawLine(
          offsetPoints[i]!,
          offsetPoints[i + 1]!,
          drawingPaint ?? kDrawingPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
