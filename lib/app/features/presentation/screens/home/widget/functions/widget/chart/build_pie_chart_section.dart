import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

PieChartSectionData buildPieChartSection(int value, Color color) {
  return PieChartSectionData(
    value: value > 0 ? value.toDouble() : 1.0,
    title: value > 0 ? value.toString() : "",
    color: color,
    radius: 100,
    titleStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}