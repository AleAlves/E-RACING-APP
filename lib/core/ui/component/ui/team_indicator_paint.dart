
import 'package:flutter/material.dart';

class TeamIndicatorPaint extends CustomPainter {

  final Color? color;

  TeamIndicatorPaint(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color ?? Colors.red;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}