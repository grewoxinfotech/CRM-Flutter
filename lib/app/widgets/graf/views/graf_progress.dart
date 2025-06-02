import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrafProgress extends StatelessWidget {
  final double percentage;
  final double size;

  GrafProgress({super.key, required this.percentage, this.size = 100}) {
    Get.put(_GrafController()).start(percentage);
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<_GrafController>();
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size - 35,
            height: size - 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Get.theme.colorScheme.onBackground),
            ),
          ),
          CustomPaint(
            size: Size(size, size),
            painter: _GrafPainter(c.progress.value),
          ),
        ],
      ),
    );
  }
}

class _GrafController extends GetxController with GetTickerProviderStateMixin {
  final progress = 0.0.obs;
  late final AnimationController _ac;

  void start(double target) {
    _ac = AnimationController(vsync: this, duration: 1.seconds);
    _ac.addListener(() => progress.value = _ac.value * target);
    _ac.forward();
  }

  @override
  void onClose() {
    _ac.dispose();
    super.onClose();
  }
}

class _GrafPainter extends CustomPainter {
  final double p;

  _GrafPainter(this.p);

  final _seg = 30, _sw = 2.5;

  @override
  void paint(Canvas c, Size s) {
    final r = s.width / 2, ctr = Offset(r, r);
    final bg = Paint()..color = Colors.grey.withOpacity(0.3);
    final fg = Paint()..color = Colors.blue;
    for (int i = 0; i < _seg; i++) {
      final a = (i * 2 * pi / _seg) - pi / 2;
      final o = Offset(ctr.dx + r * cos(a), ctr.dy + r * sin(a));
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: o, width: _sw * 2, height: _sw * 7),
        const Radius.circular(10),
      );
      c.save();
      c.translate(o.dx, o.dy);
      c.rotate(a + pi / 2);
      c.translate(-o.dx, -o.dy);
      c.drawRRect(rect, i < (p / 100 * _seg) ? fg : bg);
      c.restore();
    }

    final tp = TextPainter(
      text: TextSpan(
        text: '${p.toInt()}%',
        style: const TextStyle(
          fontSize: 22,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(c, ctr - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_GrafPainter old) => old.p != p;
}
