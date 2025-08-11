import 'dart:math';

import 'package:flutter/material.dart';

class GrafProgressPainter extends CustomPainter {
  final double progress;
  final int totalSegments = 30;
  final double strokeWidth = 2.5;

  GrafProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint backgroundPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.3)
          ..style = PaintingStyle.fill;

    Paint progressPaint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

    for (int i = 0; i < totalSegments; i++) {
      double angle = (i * (2 * pi / totalSegments)) - pi / 2;
      Offset rectCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      Rect rect = Rect.fromCenter(
        center: rectCenter,
        width: strokeWidth * 2.5,
        height: strokeWidth * 10,
      );

      RRect roundedRect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(10),
      );

      canvas.save();
      canvas.translate(rectCenter.dx, rectCenter.dy);
      canvas.rotate(angle + pi / 2);
      canvas.translate(-rectCenter.dx, -rectCenter.dy);
      canvas.drawRRect(
        roundedRect,
        i < (progress / 100 * totalSegments) ? progressPaint : backgroundPaint,
      );
      canvas.restore();
    }

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${progress.toInt()}%',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(GrafProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
