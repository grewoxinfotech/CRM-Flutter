import 'package:crm_flutter/app/features/screens/home/widget/attendance/widget/graf/features/graf_design_2.dart';
import 'package:flutter/material.dart';

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
          width: width - 40,
          height: width - 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            shape: BoxShape.circle,
          ),
        ),
        CustomPaint(
          size: Size(width, width),
          painter: CircularProgressPainter(progress),
        ),
      ],
    );
  }
}
