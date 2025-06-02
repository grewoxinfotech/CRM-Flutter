import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmChart extends StatelessWidget {
  final List<PieChartSectionData>? sections;
  final double? size;

  const CrmChart({super.key, required this.sections, this.size});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: size,
        width: size,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(show: false),
            centerSpaceRadius: 0,
            sectionsSpace: 2,
            startDegreeOffset: 20,
            sections: sections,
          ),
        ),
      ),
    );
  }
}
