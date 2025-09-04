import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AggregationPieChart extends StatefulWidget {
  final Map<String, int> aggregationData; // e.g., {"New Lead": 3, "MQL": 2}
  final List<Color> colors;

  const AggregationPieChart({
    Key? key,
    required this.aggregationData,
    this.colors = const [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ],
  }) : super(key: key);

  @override
  State<AggregationPieChart> createState() => _AggregationPieChartState();
}

class _AggregationPieChartState extends State<AggregationPieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final total = widget.aggregationData.values.fold<int>(0, (a, b) => a + b);
    final sections =
        widget.aggregationData.entries.toList().asMap().entries.map((entry) {
          int index = entry.key;
          String key = entry.value.key;
          int value = entry.value.value;

          final isTouched = index == touchedIndex;
          final double fontSize = isTouched ? 18 : 14;
          final double radius = isTouched ? 60 : 50;

          return PieChartSectionData(
            color: widget.colors[index % widget.colors.length],
            value: value.toDouble(),
            title: '$value',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList();

    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 40,
                sectionsSpace: 4,
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = null;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Legend
          // Padding(
          //   padding: const EdgeInsets.only(left: 26),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children:
          //         widget.aggregationData.keys.toList().asMap().entries.map((
          //           entry,
          //         ) {
          //           int index = entry.key;
          //           String label = entry.value;
          //           return Padding(
          //             padding: const EdgeInsets.only(bottom: 8),
          //             child: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Container(
          //                   width: 15,
          //                   height: 15,
          //                   color: widget.colors[index % widget.colors.length],
          //                 ),
          //                 const SizedBox(width: 5),
          //                 Text(label),
          //               ],
          //             ),
          //           );
          //         }).toList(),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 26),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children:
          //         widget.aggregationData.entries.toList().asMap().entries.map((
          //           entry,
          //         ) {
          //           int index = entry.key;
          //           String label = entry.value.key;
          //           int value = entry.value.value;
          //           double percentage =
          //               total == 0 ? 0 : (value / total * 100); // calculate %
          //           return Padding(
          //             padding: const EdgeInsets.only(bottom: 8, right: 12),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Container(
          //                       width: 15,
          //                       height: 15,
          //                       color:
          //                           widget.colors[index % widget.colors.length],
          //                     ),
          //                     const SizedBox(width: 5),
          //                     Text('$label'),
          //                   ],
          //                 ),
          //                 Text('${percentage.toStringAsFixed(1)}%'),
          //               ],
          //             ),
          //           );
          //         }).toList(),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  widget.aggregationData.entries.toList().asMap().entries.map((
                    entry,
                  ) {
                    int index = entry.key;
                    String label = entry.value.key;
                    int value = entry.value.value;
                    double percentage = total == 0 ? 0 : (value / total * 100);

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    color:
                                        widget.colors[index %
                                            widget.colors.length],
                                  ),
                                  const SizedBox(width: 5),
                                  Text('$label'),
                                ],
                              ),
                              Text('${percentage.toStringAsFixed(1)}%'),
                            ],
                          ),
                        ),
                        // Add divider except for the last item
                        if (index != widget.aggregationData.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Divider(
                              thickness: 0.5,
                              endIndent: 19,
                              height: 1,
                              color: Colors.grey.shade400,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
