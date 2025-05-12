import 'package:crm_flutter/app/modules/hrm/attendance/widgets/attendance/widget/graf_progress_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularProgressBar extends StatelessWidget {
  final double progress;
  final double width;

  const CircularProgressBar({
    super.key,
    required this.progress,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width - 35,
          height: width - 35,
          decoration: BoxDecoration(
            border: Border.all(color: Get.theme.colorScheme.onBackground),
            shape: BoxShape.circle,
          ),
        ),
        CustomPaint(
          size: Size(width, width),
          painter: GrafProgressPainter(progress),
        ),
      ],
    );
  }
}
