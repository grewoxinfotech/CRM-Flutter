// // import 'package:crm_flutter/app/care/constants/color_res.dart';
// // import 'package:crm_flutter/app/data/network/sales/revenue/model/revenue_menu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:intl/intl.dart';
// //
// // // class RevenueChart extends StatelessWidget {
// // //   final List<RevenueData> revenueData;
// // //
// // //   const RevenueChart({super.key, required this.revenueData});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Parse data into spots
// // //     List<FlSpot> spots = [];
// // //     List<String> dates = [];
// // //
// // //     for (int i = 0; i < revenueData.length; i++) {
// // //       final item = revenueData[i];
// // //       final revenue = (item.amount ?? 0).toDouble(); // or item["revenue"]
// // //       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
// // //
// // //       spots.add(FlSpot(i.toDouble(), revenue));
// // //       dates.add(DateFormat("MM/dd").format(date));
// // //     }
// // //
// // //     return Card(
// // //       elevation: 3,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             const Text(
// // //               "Revenue Trend",
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             SizedBox(
// // //               height: 300,
// // //               child: LineChart(
// // //                 LineChartData(
// // //                   gridData: FlGridData(show: false),
// // //                   titlesData: FlTitlesData(
// // //                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// // //                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// // //                     leftTitles: AxisTitles(
// // //                       sideTitles: SideTitles(showTitles: true, reservedSize: 50),
// // //                     ),
// // //                     bottomTitles: AxisTitles(
// // //                       sideTitles: SideTitles(
// // //                         showTitles: true,
// // //                         getTitlesWidget: (value, meta) {
// // //                           if (value.toInt() >= 0 &&
// // //                               value.toInt() < dates.length) {
// // //                             return Text(
// // //                               dates[value.toInt()],
// // //                               style: const TextStyle(fontSize: 10),
// // //                             );
// // //                           }
// // //                           return const Text("");
// // //                         },
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   borderData: FlBorderData(show: false),
// // //                   lineBarsData: [
// // //                     LineChartBarData(
// // //                       spots: spots,
// // //                       isCurved: true,
// // //                       color: Colors.blue,
// // //                       barWidth: 3,
// // //                       belowBarData: BarAreaData(
// // //                         show: true,
// // //                         color: Colors.blue.withOpacity(0.2),
// // //                       ),
// // //                       dotData: FlDotData(show: false),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // // class RevenueChart extends StatelessWidget {
// // //   final List<RevenueData> revenueData;
// // //
// // //   const RevenueChart({super.key, required this.revenueData});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Parse data into spots
// // //     List<FlSpot> spots = [];
// // //     List<String> dates = [];
// // //
// // //     double maxRevenue = 0;
// // //
// // //     for (int i = 0; i < revenueData.length; i++) {
// // //       final item = revenueData[i];
// // //       final revenue = (item.amount ?? 0).toDouble();
// // //       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
// // //
// // //       spots.add(FlSpot(i.toDouble(), revenue));
// // //       dates.add(DateFormat("MM/dd").format(date));
// // //
// // //       if (revenue > maxRevenue) {
// // //         maxRevenue = revenue;
// // //       }
// // //     }
// // //
// // //     return Card(
// // //       elevation: 3,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             const Text(
// // //               "Revenue Trend",
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             SizedBox(
// // //               height: 300,
// // //               child: LineChart(
// // //                 LineChartData(
// // //                   minY: 0,
// // //                   maxY: maxRevenue, // <-- max value from data
// // //                   gridData: FlGridData(show: false),
// // //                   titlesData: FlTitlesData(
// // //                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// // //                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// // //                     leftTitles: AxisTitles(
// // //                       sideTitles: SideTitles(showTitles: true, reservedSize: 50),
// // //                     ),
// // //                     bottomTitles: AxisTitles(
// // //                       sideTitles: SideTitles(
// // //                         showTitles: true,
// // //                         getTitlesWidget: (value, meta) {
// // //                           if (value.toInt() >= 0 && value.toInt() < dates.length) {
// // //                             return Padding(
// // //                               padding: const EdgeInsets.only(top: 8.0),
// // //                               child: Text(
// // //                                 dates[value.toInt()],
// // //                                 style: const TextStyle(fontSize: 10),
// // //                               ),
// // //                             );
// // //                           }
// // //                           return const Text("");
// // //                         },
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   borderData: FlBorderData(show: false),
// // //                   lineBarsData: [
// // //                     LineChartBarData(
// // //                       spots: spots,
// // //                       isCurved: true,
// // //                       color: Colors.blue,
// // //                       barWidth: 3,
// // //                       belowBarData: BarAreaData(
// // //                         show: true,
// // //                         color: Colors.blue.withOpacity(0.2),
// // //                       ),
// // //                       dotData: FlDotData(show: false),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // // class RevenueChart extends StatelessWidget {
// // //   final List<RevenueData> revenueData;
// // //
// // //   const RevenueChart({super.key, required this.revenueData});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Parse data into spots
// // //     List<FlSpot> spots = [];
// // //     List<String> dates = [];
// // //
// // //     double maxRevenue = 0;
// // //
// // //     for (int i = 0; i < revenueData.length; i++) {
// // //       final item = revenueData[i];
// // //       final revenue = (item.amount ?? 0).toDouble();
// // //       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
// // //
// // //       spots.add(FlSpot(i.toDouble(), revenue));
// // //       dates.add(DateFormat("MM/dd").format(date));
// // //
// // //       if (revenue > maxRevenue) {
// // //         maxRevenue = revenue;
// // //       }
// // //     }
// // //
// // //     return Card(
// // //       elevation: 3,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             const Text(
// // //               "Revenue Trend",
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             SizedBox(
// // //               height: 300,
// // //               child: LineChart(
// // //                 LineChartData(
// // //                   minY: 0,
// // //                   maxY: maxRevenue,
// // //                   gridData: FlGridData(show: false),
// // //                   titlesData: FlTitlesData(
// // //                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// // //                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// // //
// // //                     // ✅ Left axis with efficient formatting
// // //                     leftTitles: AxisTitles(
// // //                       sideTitles: SideTitles(
// // //                         showTitles: true,
// // //                         reservedSize: 40,
// // //                         interval: maxRevenue / 5, // ~5 steps
// // //                         getTitlesWidget: (value, meta) {
// // //                           return Text(
// // //                             _formatNumber(value),
// // //                             style: const TextStyle(fontSize: 10),
// // //                           );
// // //                         },
// // //                       ),
// // //                     ),
// // //
// // //                     // ✅ Bottom axis (dates)
// // //                     bottomTitles: AxisTitles(
// // //                       sideTitles: SideTitles(
// // //                         showTitles: true,
// // //                         getTitlesWidget: (value, meta) {
// // //                           if (value.toInt() >= 0 && value.toInt() < dates.length) {
// // //                             return Padding(
// // //                               padding: const EdgeInsets.only(top: 8.0),
// // //                               child: Text(
// // //                                 dates[value.toInt()],
// // //                                 style: const TextStyle(fontSize: 10),
// // //                               ),
// // //                             );
// // //                           }
// // //                           return const SizedBox.shrink();
// // //                         },
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   borderData: FlBorderData(show: false),
// // //                   lineBarsData: [
// // //                     LineChartBarData(
// // //                       spots: spots,
// // //                       isCurved: true,
// // //                       color: Colors.blue,
// // //                       barWidth: 3,
// // //                       belowBarData: BarAreaData(
// // //                         show: true,
// // //                         color: Colors.blue.withOpacity(0.2),
// // //                       ),
// // //                       dotData: FlDotData(show: false),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   /// ✅ Number formatting for axis labels
// // //   String _formatNumber(double value) {
// // //     if (value >= 10000000) {
// // //       return "${(value / 10000000).toStringAsFixed(1)}Cr"; // Crores
// // //     } else if (value >= 100000) {
// // //       return "${(value / 100000).toStringAsFixed(1)}L"; // Lakhs
// // //     } else if (value >= 1000) {
// // //       return "${(value / 1000).toStringAsFixed(1)}K"; // Thousands
// // //     } else {
// // //       return value.toStringAsFixed(0);
// // //     }
// // //   }
// // // }
// //
// //
// // import 'package:crm_flutter/app/data/network/sales/revenue/model/revenue_menu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:intl/intl.dart';
// //
// // class RevenueChart extends StatelessWidget {
// //   final List<RevenueData> revenueData;
// //
// //   const RevenueChart({super.key, required this.revenueData});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (revenueData.isEmpty) {
// //       return const Center(child: Text("No revenue data available"));
// //     }
// //
// //     // Parse data into spots
// //     List<FlSpot> spots = [];
// //     List<String> dates = [];
// //
// //     double maxRevenue = 0;
// //
// //     for (int i = 0; i < revenueData.length; i++) {
// //       final item = revenueData[i];
// //       final revenue = (item.amount ?? 0).toDouble();
// //       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
// //
// //       spots.add(FlSpot(i.toDouble(), revenue));
// //       dates.add(DateFormat("MMM-dd").format(date));
// //
// //       if (revenue > maxRevenue) {
// //         maxRevenue = revenue;
// //       }
// //     }
// //
// //     // ✅ Only show ~8 labels on x-axis
// //     int labelCount = 5;
// //     double interval = (revenueData.length - 1) / (labelCount - 1);
// //
// //     return Card(
// //       elevation: 3,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             const Text(
// //               "Revenue Trend",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 16),
// //             SizedBox(
// //               height: 300,
// //               child: LineChart(
// //
// //                 LineChartData(
// //
// //                   lineTouchData: LineTouchData(
// //                     enabled: true,
// //                     touchTooltipData: LineTouchTooltipData(
// //                       // ✅ Dynamically change tooltip color
// //                       getTooltipColor: (LineBarSpot touchedSpot) {
// //                         // Example: make color darker as revenue increases
// //
// //                         return ColorRes.primary.withOpacity(0.8);
// //                       },
// //
// //                       getTooltipItems: (touchedSpots) {
// //                         return touchedSpots.map((spot) {
// //                           final index = spot.x.toInt();
// //                           final date = dates[index];
// //                           final revenue = spot.y;
// //
// //                           return LineTooltipItem(
// //                             "$date\n₹ ${_formatNumber(revenue)}",
// //                             const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           );
// //                         }).toList();
// //                       },
// //                     ),
// //                   ),
// //
// //                   minY: 0,
// //                   maxY: maxRevenue,
// //                   gridData: FlGridData(show: false),
// //                   titlesData: FlTitlesData(
// //                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// //                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// //
// //                     // ✅ Left axis with efficient formatting
// //                     leftTitles: AxisTitles(
// //                       sideTitles: SideTitles(
// //                         showTitles: true,
// //                         reservedSize: 40,
// //                         interval: maxRevenue / 5, // ~5 steps
// //                         getTitlesWidget: (value, meta) {
// //                           return Text(
// //                             _formatNumber(value),
// //                             style: const TextStyle(fontSize: 10),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                     // ✅ Bottom axis (efficient with only ~8 points)
// //                     bottomTitles: AxisTitles(
// //                       sideTitles: SideTitles(
// //                         showTitles: true,
// //                         interval: interval, // show only selected points
// //                         getTitlesWidget: (value, meta) {
// //                           int index = value.toInt();
// //                           if (index >= 0 && index < dates.length) {
// //                             return Padding(
// //                               padding: const EdgeInsets.only(top: 8.0),
// //                               child: Text(
// //                                 dates[index],
// //                                 style: const TextStyle(fontSize: 10),
// //                               ),
// //                             );
// //                           }
// //                           return const SizedBox.shrink();
// //                         },
// //                       ),
// //                     ),
// //                   ),
// //                   borderData: FlBorderData(show: false),
// //                   lineBarsData: [
// //                     LineChartBarData(
// //                       spots: spots,
// //                       isCurved: true,
// //                       color: Colors.blue,
// //                       barWidth: 3,
// //                       belowBarData: BarAreaData(
// //                         show: true,
// //                         color: ColorRes.primary.withOpacity(0.1),
// //                       ),
// //                       dotData: FlDotData(show: false),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   /// ✅ Number formatting for axis labels
// //   String _formatNumber(double value) {
// //     if (value >= 10000000) {
// //       return "${(value / 10000000).toStringAsFixed(1)}Cr"; // Crores
// //     } else if (value >= 100000) {
// //       return "${(value / 100000).toStringAsFixed(1)}L"; // Lakhs
// //     } else if (value >= 1000) {
// //       return "${(value / 1000).toStringAsFixed(1)}K"; // Thousands
// //     } else {
// //       return value.toStringAsFixed(0);
// //     }
// //   }
// // }
//
// // import 'package:crm_flutter/app/data/network/sales/revenue/model/revenue_menu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:intl/intl.dart';
// // import 'package:crm_flutter/app/care/constants/color_res.dart';
// //
// // import '../../../widgets/common/inputs/crm_dropdown_field.dart';
// //
// // class RevenueChart extends StatefulWidget {
// //   final List<RevenueData> revenueData;
// //
// //   const RevenueChart({super.key, required this.revenueData});
// //
// //   @override
// //   State<RevenueChart> createState() => _RevenueChartState();
// // }
// //
// // class _RevenueChartState extends State<RevenueChart> {
// //   int selectedMonth = DateTime.now().month; // default current month
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Filter data by selected month
// //     List<RevenueData> filteredData =
// //         widget.revenueData.where((e) {
// //           final date = DateTime.tryParse(e.date!) ?? DateTime.now();
// //           return date.month == selectedMonth;
// //         }).toList();
// //
// //     // Parse data into chart spots
// //     List<FlSpot> spots = [];
// //     List<String> dates = [];
// //     double maxRevenue = 0;
// //
// //     for (int i = 0; i < filteredData.length; i++) {
// //       final item = filteredData[i];
// //       final revenue = (item.amount ?? 0).toDouble();
// //       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
// //
// //       spots.add(FlSpot(i.toDouble(), revenue));
// //       dates.add(DateFormat("MMM-dd").format(date));
// //
// //       if (revenue > maxRevenue) maxRevenue = revenue;
// //     }
// //
// //     // Horizontal month filter buttons
// //     List<String> monthNames = List.generate(
// //       12,
// //       (index) => DateFormat("MMM").format(DateTime(0, index + 1)),
// //     );
// //
// //     return Card(
// //       elevation: 3,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: const Text(
// //                     "Revenue Trend",
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: CrmDropdownField<int>(
// //                     value: selectedMonth,
// //                     items: List.generate(
// //                       12,
// //                       (index) => DropdownMenuItem(
// //                         value: index + 1,
// //                         child: Text(monthNames[index]),
// //                       ),
// //                     ),
// //                     onChanged: (month) {
// //                       setState(() {
// //                         selectedMonth = month;
// //                       });
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //
// //             // Line chart
// //             SizedBox(
// //               height: 300,
// //               child:
// //                   filteredData.isEmpty
// //                       ? const Center(
// //                         child: Text("No revenue data for this month"),
// //                       )
// //                       : LineChart(
// //                         LineChartData(
// //                           lineTouchData: LineTouchData(
// //                             enabled: true,
// //                             touchTooltipData: LineTouchTooltipData(
// //                               getTooltipItems: (spots) {
// //                                 return spots.map((spot) {
// //                                   final index = spot.x.toInt();
// //                                   final date = dates[index];
// //                                   final revenue = spot.y;
// //                                   return LineTooltipItem(
// //                                     "$date\n₹ ${_formatNumber(revenue)}",
// //                                     const TextStyle(
// //                                       color: Colors.white,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   );
// //                                 }).toList();
// //                               },
// //                             ),
// //                           ),
// //                           minY: 0,
// //                           maxY: maxRevenue,
// //                           gridData: FlGridData(show: false),
// //                           titlesData: FlTitlesData(
// //                             rightTitles: AxisTitles(
// //                               sideTitles: SideTitles(showTitles: false),
// //                             ),
// //                             topTitles: AxisTitles(
// //                               sideTitles: SideTitles(showTitles: false),
// //                             ),
// //                             leftTitles: AxisTitles(
// //                               sideTitles: SideTitles(
// //                                 showTitles: true,
// //                                 reservedSize: 40,
// //                                 interval: maxRevenue / 5,
// //                                 getTitlesWidget:
// //                                     (value, meta) => Text(
// //                                       _formatNumber(value),
// //                                       style: const TextStyle(fontSize: 10),
// //                                     ),
// //                               ),
// //                             ),
// //                             bottomTitles: AxisTitles(
// //                               sideTitles: SideTitles(
// //                                 showTitles: true,
// //                                 interval: 1,
// //                                 getTitlesWidget: (value, meta) {
// //                                   int index = value.toInt();
// //                                   if (index >= 0 && index < dates.length) {
// //                                     return Padding(
// //                                       padding: const EdgeInsets.only(top: 8.0),
// //                                       child: Text(
// //                                         dates[index],
// //                                         style: const TextStyle(fontSize: 10),
// //                                       ),
// //                                     );
// //                                   }
// //                                   return const SizedBox.shrink();
// //                                 },
// //                               ),
// //                             ),
// //                           ),
// //                           borderData: FlBorderData(show: false),
// //                           lineBarsData: [
// //                             LineChartBarData(
// //                               spots: spots,
// //                               isCurved: true,
// //                               color: Colors.blue,
// //                               barWidth: 3,
// //                               belowBarData: BarAreaData(
// //                                 show: true,
// //                                 color: ColorRes.primary.withOpacity(0.1),
// //                               ),
// //                               dotData: FlDotData(show: false),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   String _formatNumber(double value) {
// //     if (value >= 10000000) return "${(value / 10000000).toStringAsFixed(1)}Cr";
// //     if (value >= 100000) return "${(value / 100000).toStringAsFixed(1)}L";
// //     if (value >= 1000) return "${(value / 1000).toStringAsFixed(1)}K";
// //     return value.toStringAsFixed(0);
// //   }
// // }
//
// import 'package:crm_flutter/app/data/network/sales/revenue/model/revenue_menu.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:crm_flutter/app/care/constants/color_res.dart';
//
// import '../../../care/constants/size_manager.dart';
// import '../../../widgets/common/inputs/crm_dropdown_field.dart';
//
// class RevenueChart extends StatefulWidget {
//   final List<RevenueData> revenueData;
//
//   const RevenueChart({super.key, required this.revenueData});
//
//   @override
//   State<RevenueChart> createState() => _RevenueChartState();
// }
//
// class _RevenueChartState extends State<RevenueChart> {
//   DateTime? selectedMonthYear;
//   List<DateTime> monthYearList = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.revenueData.isNotEmpty) {
//       // Schedule after first frame to avoid setState during build
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Sort data by date
//         widget.revenueData.sort((a, b) {
//           final dateA = DateTime.tryParse(a.date!) ?? DateTime.now();
//           final dateB = DateTime.tryParse(b.date!) ?? DateTime.now();
//           return dateA.compareTo(dateB);
//         });
//
//         DateTime firstDate =
//             DateTime.tryParse(widget.revenueData.first.date!) ?? DateTime.now();
//         DateTime lastDate = DateTime.now();
//
//         final list = _generateMonthYearList(firstDate, lastDate);
//
//         setState(() {
//           monthYearList = list;
//           selectedMonthYear = monthYearList.last; // default current month
//         });
//       });
//     }
//   }
//
//   // Generate all months between start and end
//   List<DateTime> _generateMonthYearList(DateTime start, DateTime end) {
//     List<DateTime> list = [];
//     DateTime current = DateTime(start.year, start.month);
//
//     while (!current.isAfter(DateTime(end.year, end.month))) {
//       list.add(current);
//       current = DateTime(
//         current.month == 12 ? current.year + 1 : current.year,
//         current.month == 12 ? 1 : current.month + 1,
//       );
//     }
//     return list;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter data by selected month-year
//     List<RevenueData> filteredData =
//         widget.revenueData.where((e) {
//           final date = DateTime.tryParse(e.date!) ?? DateTime.now();
//           return date.year ==
//                   (selectedMonthYear?.year ?? DateTime.now().year) &&
//               date.month == (selectedMonthYear?.month ?? DateTime.now().month);
//         }).toList();
//
//     // Prepare chart data
//     List<FlSpot> spots = [];
//     List<String> dates = [];
//     double maxRevenue = 0;
//
//     for (int i = 0; i < filteredData.length; i++) {
//       final item = filteredData[i];
//       final revenue = (item.amount ?? 0).toDouble();
//       final date = DateTime.tryParse(item.date!) ?? DateTime.now();
//
//       spots.add(FlSpot(i.toDouble(), revenue));
//       dates.add(DateFormat("MMM-dd").format(date));
//
//       if (revenue > maxRevenue) maxRevenue = revenue;
//     }
//
//     return CrmCard(
//       margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
//       padding: EdgeInsets.all(AppPadding.small),
//
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     "Revenue Trend",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Expanded(
//                   child: CrmDropdownField<DateTime>(
//                     value: selectedMonthYear,
//                     items:
//                         monthYearList.map((month) {
//                           return DropdownMenuItem(
//                             value: month,
//                             child: Text(DateFormat("MMM yyyy").format(month)),
//                           );
//                         }).toList(),
//                     onChanged: (month) {
//                       setState(() {
//                         selectedMonthYear = month;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             SizedBox(
//               height: 300,
//               child:
//                   filteredData.isEmpty
//                       ? const Center(
//                         child: Text("No revenue data for this month"),
//                       )
//                       : LineChart(
//                         LineChartData(
//                           lineTouchData: LineTouchData(
//                             enabled: true,
//                             touchTooltipData: LineTouchTooltipData(
//                               getTooltipItems: (spots) {
//                                 return spots.map((spot) {
//                                   final index = spot.x.toInt();
//                                   final date = dates[index];
//                                   final revenue = spot.y;
//                                   return LineTooltipItem(
//                                     "$date\n₹ ${_formatNumber(revenue)}",
//                                     const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   );
//                                 }).toList();
//                               },
//                             ),
//                           ),
//                           minY: 0,
//                           maxY: maxRevenue,
//                           gridData: FlGridData(show: false),
//                           titlesData: FlTitlesData(
//                             rightTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             topTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             leftTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 showTitles: true,
//                                 reservedSize: 40,
//                                 interval: maxRevenue / 5,
//                                 getTitlesWidget:
//                                     (value, meta) => Text(
//                                       _formatNumber(value),
//                                       style: const TextStyle(fontSize: 10),
//                                     ),
//                               ),
//                             ),
//                             bottomTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 showTitles: true,
//                                 interval: 1,
//                                 getTitlesWidget: (value, meta) {
//                                   int index = value.toInt();
//                                   if (index >= 0 && index < dates.length) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Text(
//                                         dates[index],
//                                         style: const TextStyle(fontSize: 10),
//                                       ),
//                                     );
//                                   }
//                                   return const SizedBox.shrink();
//                                 },
//                               ),
//                             ),
//                           ),
//                           borderData: FlBorderData(show: false),
//                           lineBarsData: [
//                             LineChartBarData(
//                               spots: spots,
//                               isCurved: true,
//                               color: Colors.blue,
//                               barWidth: 3,
//                               belowBarData: BarAreaData(
//                                 show: true,
//                                 color: ColorRes.primary.withOpacity(0.1),
//                               ),
//                               dotData: FlDotData(show: false),
//                             ),
//                           ],
//                         ),
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _formatNumber(double value) {
//     if (value >= 10000000) return "${(value / 10000000).toStringAsFixed(1)}Cr";
//     if (value >= 100000) return "${(value / 100000).toStringAsFixed(1)}L";
//     if (value >= 1000) return "${(value / 1000).toStringAsFixed(1)}K";
//     return value.toStringAsFixed(0);
//   }
// }


import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../../care/constants/color_res.dart';
import '../../../care/constants/size_manager.dart';
import '../../../data/network/sales/revenue/model/revenue_menu.dart';
import '../../../widgets/common/display/crm_card.dart';
import '../../../widgets/common/inputs/crm_dropdown_field.dart';

class RevenueChart extends StatefulWidget {
  final List<RevenueData> revenueData;

  const RevenueChart({super.key, required this.revenueData});

  @override
  State<RevenueChart> createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  DateTime? selectedMonthYear;
  List<DateTime> monthYearList = [];

  @override
  void initState() {
    super.initState();

    if (widget.revenueData.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.revenueData.sort((a, b) {
          final dateA = DateTime.tryParse(a.date!) ?? DateTime.now();
          final dateB = DateTime.tryParse(b.date!) ?? DateTime.now();
          return dateA.compareTo(dateB);
        });

        DateTime firstDate =
            DateTime.tryParse(widget.revenueData.first.date!) ?? DateTime.now();
        DateTime lastDate = DateTime.now();

        final list = _generateMonthYearList(firstDate, lastDate);

        setState(() {
          monthYearList = list;
          selectedMonthYear = monthYearList.last;
        });
      });
    }
  }

  List<DateTime> _generateMonthYearList(DateTime start, DateTime end) {
    List<DateTime> list = [];
    DateTime current = DateTime(start.year, start.month);

    while (!current.isAfter(DateTime(end.year, end.month))) {
      list.add(current);
      current = DateTime(
        current.month == 12 ? current.year + 1 : current.year,
        current.month == 12 ? 1 : current.month + 1,
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<RevenueData> filteredData = widget.revenueData.where((e) {
      final date = DateTime.tryParse(e.date!) ?? DateTime.now();
      return date.year == (selectedMonthYear?.year ?? DateTime.now().year) &&
          date.month == (selectedMonthYear?.month ?? DateTime.now().month);
    }).toList();

    List<FlSpot> spots = [];
    List<String> dates = [];
    double maxRevenue = 0;
    double minRevenue = double.infinity;

    for (int i = 0; i < filteredData.length; i++) {
      final item = filteredData[i];
      final revenue = (item.amount ?? 0).toDouble();
      final date = DateTime.tryParse(item.date!) ?? DateTime.now();

      if (revenue > maxRevenue) maxRevenue = revenue;
      if (revenue < minRevenue) minRevenue = revenue;

      dates.add(DateFormat("MMM-dd").format(date));
    }

    // Auto log scale check
    bool useLog = maxRevenue / (minRevenue == 0 ? 1 : minRevenue) > 1000;

    for (int i = 0; i < filteredData.length; i++) {
      final item = filteredData[i];
      final revenue = (item.amount ?? 0).toDouble();

      double yValue = useLog ? log(revenue + 1) : revenue;
      spots.add(FlSpot(i.toDouble(), yValue));
    }

    double maxY = useLog ? log(maxRevenue + 1) : maxRevenue * 1.2;

    return CrmCard(
      margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      // padding: EdgeInsets.all(AppPadding.small),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Revenue Trend",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: CrmDropdownField<DateTime>(
                    value: selectedMonthYear,
                    items: monthYearList.map((month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Text(DateFormat("MMM yyyy").format(month)),
                      );
                    }).toList(),
                    onChanged: (month) {
                      setState(() {
                        selectedMonthYear = month;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: filteredData.isEmpty
                  ? const Center(child: Text("No revenue data for this month"))
                  : LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          final index = spot.x.toInt();
                          final date = dates[index];
                          final yValue =
                          useLog ? exp(spot.y) - 1 : spot.y;
                          return LineTooltipItem(
                            "$date\n₹ ${_formatNumber(yValue)}",
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
                  maxY: maxY,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: maxY / 5,
                        getTitlesWidget: (value, meta) {
                          double realValue =
                          useLog ? exp(value) - 1 : value;
                          return Text(
                            _formatNumber(realValue),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
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

  String _formatNumber(double value) {
    if (value >= 10000000) return "${(value / 10000000).toStringAsFixed(1)}Cr";
    if (value >= 100000) return "${(value / 100000).toStringAsFixed(1)}L";
    if (value >= 1000) return "${(value / 1000).toStringAsFixed(1)}K";
    return value.toStringAsFixed(0);
  }
}