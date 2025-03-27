import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildPieChart(List<PieChartSectionData>? sections ) {
  return SizedBox(
    height: 200,
    width: 200,
    child: PieChart(
      PieChartData(
        borderData: FlBorderData(show: false),
        centerSpaceRadius: 0,
        sectionsSpace: 2,
        sections: sections,
      ),
    ),
  );
}
