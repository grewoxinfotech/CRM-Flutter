import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

PieChartSectionData CrmChartTile(int value, Color color,double radius) {
  return PieChartSectionData(
    value: value > 0 ? value.toDouble() : 1.0,
    title: value > 0 ? value.toString() : "",
    color: color,
    radius: radius,
    titleStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.theme.colorScheme.surface,
    ),
  );
}