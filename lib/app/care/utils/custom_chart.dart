import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

typedef StageExtractor<T> = String? Function(T item);
typedef ValueExtractor<T> = double Function(T item);

class DynamicBarChart<T> extends StatelessWidget {
  final List<T> data;
  final StageExtractor<T> getStage;
  final ValueExtractor<T> getValue;
  final Color barColor;
  final double barWidth;
  final double height;

  const DynamicBarChart({
    super.key,
    required this.data,
    required this.getStage,
    required this.getValue,
    this.barColor = Colors.blue,
    this.barWidth = 20,
    this.height = 250,
  });

  Map<String, double> _groupByStage() {
    final Map<String, double> grouped = {};
    for (var item in data) {
      final stage = getStage(item) ?? "Unknown";
      final value = getValue(item);
      grouped[stage] = (grouped[stage] ?? 0) + value;
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedData = _groupByStage();
    final stages = groupedData.keys.toList();
    final values = groupedData.values.toList();

    if (stages.isEmpty)
      return SizedBox(height: height, child: Center(child: Text("No data")));

    final maxY = (values.reduce((a, b) => a > b ? a : b) + 1).toDouble();

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY,
            barGroups: List.generate(stages.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: values[index].toDouble(),
                    color: barColor,
                    width: barWidth,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    if (idx >= 0 && idx < stages.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          stages[idx],
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }
                    return Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 10,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}
