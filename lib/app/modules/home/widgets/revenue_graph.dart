import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/data/network/sales/revenue/model/revenue_menu.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

// class RevenueChart extends StatelessWidget {
//   final List<RevenueData> revenueData;
//
//   const RevenueChart({super.key, required this.revenueData});
//
//   @override
//   Widget build(BuildContext context) {
//     // Parse data into spots
//     List<FlSpot> spots = [];
//     List<String> dates = [];
//
//     for (int i = 0; i < revenueData.length; i++) {
//       final item = revenueData[i];
//       final revenue = (item.amount ?? 0).toDouble(); // or item["revenue"]
//       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
//
//       spots.add(FlSpot(i.toDouble(), revenue));
//       dates.add(DateFormat("MM/dd").format(date));
//     }
//
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text(
//               "Revenue Trend",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: true, reservedSize: 50),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           if (value.toInt() >= 0 &&
//                               value.toInt() < dates.length) {
//                             return Text(
//                               dates[value.toInt()],
//                               style: const TextStyle(fontSize: 10),
//                             );
//                           }
//                           return const Text("");
//                         },
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: spots,
//                       isCurved: true,
//                       color: Colors.blue,
//                       barWidth: 3,
//                       belowBarData: BarAreaData(
//                         show: true,
//                         color: Colors.blue.withOpacity(0.2),
//                       ),
//                       dotData: FlDotData(show: false),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RevenueChart extends StatelessWidget {
//   final List<RevenueData> revenueData;
//
//   const RevenueChart({super.key, required this.revenueData});
//
//   @override
//   Widget build(BuildContext context) {
//     // Parse data into spots
//     List<FlSpot> spots = [];
//     List<String> dates = [];
//
//     double maxRevenue = 0;
//
//     for (int i = 0; i < revenueData.length; i++) {
//       final item = revenueData[i];
//       final revenue = (item.amount ?? 0).toDouble();
//       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
//
//       spots.add(FlSpot(i.toDouble(), revenue));
//       dates.add(DateFormat("MM/dd").format(date));
//
//       if (revenue > maxRevenue) {
//         maxRevenue = revenue;
//       }
//     }
//
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text(
//               "Revenue Trend",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                   minY: 0,
//                   maxY: maxRevenue, // <-- max value from data
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: true, reservedSize: 50),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           if (value.toInt() >= 0 && value.toInt() < dates.length) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 dates[value.toInt()],
//                                 style: const TextStyle(fontSize: 10),
//                               ),
//                             );
//                           }
//                           return const Text("");
//                         },
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: spots,
//                       isCurved: true,
//                       color: Colors.blue,
//                       barWidth: 3,
//                       belowBarData: BarAreaData(
//                         show: true,
//                         color: Colors.blue.withOpacity(0.2),
//                       ),
//                       dotData: FlDotData(show: false),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class RevenueChart extends StatelessWidget {
//   final List<RevenueData> revenueData;
//
//   const RevenueChart({super.key, required this.revenueData});
//
//   @override
//   Widget build(BuildContext context) {
//     // Parse data into spots
//     List<FlSpot> spots = [];
//     List<String> dates = [];
//
//     double maxRevenue = 0;
//
//     for (int i = 0; i < revenueData.length; i++) {
//       final item = revenueData[i];
//       final revenue = (item.amount ?? 0).toDouble();
//       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
//
//       spots.add(FlSpot(i.toDouble(), revenue));
//       dates.add(DateFormat("MM/dd").format(date));
//
//       if (revenue > maxRevenue) {
//         maxRevenue = revenue;
//       }
//     }
//
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text(
//               "Revenue Trend",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                   minY: 0,
//                   maxY: maxRevenue,
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//
//                     // ✅ Left axis with efficient formatting
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         interval: maxRevenue / 5, // ~5 steps
//                         getTitlesWidget: (value, meta) {
//                           return Text(
//                             _formatNumber(value),
//                             style: const TextStyle(fontSize: 10),
//                           );
//                         },
//                       ),
//                     ),
//
//                     // ✅ Bottom axis (dates)
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           if (value.toInt() >= 0 && value.toInt() < dates.length) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 dates[value.toInt()],
//                                 style: const TextStyle(fontSize: 10),
//                               ),
//                             );
//                           }
//                           return const SizedBox.shrink();
//                         },
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: spots,
//                       isCurved: true,
//                       color: Colors.blue,
//                       barWidth: 3,
//                       belowBarData: BarAreaData(
//                         show: true,
//                         color: Colors.blue.withOpacity(0.2),
//                       ),
//                       dotData: FlDotData(show: false),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// ✅ Number formatting for axis labels
//   String _formatNumber(double value) {
//     if (value >= 10000000) {
//       return "${(value / 10000000).toStringAsFixed(1)}Cr"; // Crores
//     } else if (value >= 100000) {
//       return "${(value / 100000).toStringAsFixed(1)}L"; // Lakhs
//     } else if (value >= 1000) {
//       return "${(value / 1000).toStringAsFixed(1)}K"; // Thousands
//     } else {
//       return value.toStringAsFixed(0);
//     }
//   }
// }


import 'package:crm_flutter/app/data/network/sales/revenue/model/revenue_menu.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RevenueChart extends StatelessWidget {
  final List<RevenueData> revenueData;

  const RevenueChart({super.key, required this.revenueData});

  @override
  Widget build(BuildContext context) {
    if (revenueData.isEmpty) {
      return const Center(child: Text("No revenue data available"));
    }

    // Parse data into spots
    List<FlSpot> spots = [];
    List<String> dates = [];

    double maxRevenue = 0;

    for (int i = 0; i < revenueData.length; i++) {
      final item = revenueData[i];
      final revenue = (item.amount ?? 0).toDouble();
      final date = DateTime.tryParse(item.date!) ?? DateTime.now();

      spots.add(FlSpot(i.toDouble(), revenue));
      dates.add(DateFormat("MMM-dd").format(date));

      if (revenue > maxRevenue) {
        maxRevenue = revenue;
      }
    }

    // ✅ Only show ~8 labels on x-axis
    int labelCount = 5;
    double interval = (revenueData.length - 1) / (labelCount - 1);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Revenue Trend",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(

                LineChartData(

                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      // ✅ Dynamically change tooltip color
                      getTooltipColor: (LineBarSpot touchedSpot) {
                        // Example: make color darker as revenue increases

                        return ColorRes.primary.withOpacity(0.8);
                      },

                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final index = spot.x.toInt();
                          final date = dates[index];
                          final revenue = spot.y;

                          return LineTooltipItem(
                            "$date\n₹ ${_formatNumber(revenue)}",
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),

                  minY: 0,
                  maxY: maxRevenue,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                    // ✅ Left axis with efficient formatting
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: maxRevenue / 5, // ~5 steps
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _formatNumber(value),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    // ✅ Bottom axis (efficient with only ~8 points)
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: interval, // show only selected points
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < dates.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                dates[index],
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: ColorRes.primary.withOpacity(0.1),
                      ),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Number formatting for axis labels
  String _formatNumber(double value) {
    if (value >= 10000000) {
      return "${(value / 10000000).toStringAsFixed(1)}Cr"; // Crores
    } else if (value >= 100000) {
      return "${(value / 100000).toStringAsFixed(1)}L"; // Lakhs
    } else if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(1)}K"; // Thousands
    } else {
      return value.toStringAsFixed(0);
    }
  }
}
