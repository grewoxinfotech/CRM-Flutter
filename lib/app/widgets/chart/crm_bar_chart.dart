import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CrmBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 100,
        borderData: FlBorderData(show: false),
        barGroups: [
          makeGroupData(0, 50),
          makeGroupData(1, 80),
          makeGroupData(2, 30),
          makeGroupData(3, 40),
          makeGroupData(4, 50),
          makeGroupData(5, 0),
          makeGroupData(6, 0),
        ],
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget:
                  (value, _) => Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Set', 'Sun'][value
                          .toInt()],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 20,
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [AppColors.primary.withOpacity(0.5), AppColors.primary],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
