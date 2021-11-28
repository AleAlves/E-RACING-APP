import 'dart:math';

import 'package:flutter/material.dart';

class CustomBackground extends CustomPainter {
  final Paint mainPaint;
  final Paint middlePaint;
  final Paint lowerPaint;
  final Paint segment;

  CustomBackground()
      : mainPaint = Paint(),
        middlePaint = Paint(),
        lowerPaint = Paint(),
        segment = Paint(){
    mainPaint.color = const Color(0x80e2e2e2);
    mainPaint.isAntiAlias = true;
    mainPaint.style = PaintingStyle.fill;

    middlePaint.color = const Color(0x72f1f1f1);
    middlePaint.isAntiAlias = true;
    middlePaint.style = PaintingStyle.fill;

    lowerPaint.color = const Color(0x6be3e3e3);
    lowerPaint.isAntiAlias = true;
    lowerPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    drawBellAndLeg(radius, canvas, size);

    canvas.restore();
  }

  void drawBellAndLeg(radius, canvas, Size size) {
    final upper = Path();
    upper.lineTo(0, size.height / 4);
    upper.lineTo(size.width, 0);

    final lower = Path();
    lower.lineTo(0, size.height);
    lower.lineTo(size.width, size.height);

    final right = Path();
    right.lineTo(100, size.height);
    right.lineTo(size.width, size.height - 100);
    right.lineTo(size.width, size.height);
    right.lineTo(100, size.height);

    canvas.drawPath(lower, lowerPaint);
    canvas.drawPath(upper, middlePaint);
    canvas.drawPath(right, mainPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

