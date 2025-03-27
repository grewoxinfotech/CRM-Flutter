import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  RxDouble progress = 0.0.obs;

  void startAnimation(double targetPercentage) {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 0, end: targetPercentage).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic),
    )..addListener(() {
      progress.value = animation.value;
    });

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class CustomCircularProgress extends StatelessWidget {
  final double percentage;
  final ProgressController controller = Get.put(ProgressController());

  CustomCircularProgress({super.key, required this.percentage}) {
    controller.startAnimation(percentage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            shape: BoxShape.circle,
          ),
        ),
        Obx(() => CircularProgressBar(progress: controller.progress.value)),
      ],
    );
  }
}

class CircularProgressBar extends StatelessWidget {
  final double progress;

  const CircularProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(150, 150),
      painter: CircularProgressPainter(progress),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final int totalSegments = 30;
  final double strokeWidth = 2.5;

  CircularProgressPainter(this.progress);

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
        width: strokeWidth * 2,
        height: strokeWidth * 10,
      );

      RRect roundedRect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(5),
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
  bool shouldRepaint(CircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
