import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/functions/controller/function_controller.dart';
import 'package:crm_flutter/app/modules/functions/widget/functions_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/views/attendance_widget.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/crm/lead/model/lead_model.dart';
import '../../../widgets/common/display/crm_headline.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(FunctionController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final LeadController leadController = Get.put(LeadController());
    List widgets = [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.medium * 2,
          vertical: AppPadding.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Evan, Welcome back!",
              style: TextStyle(
                fontSize: 14,
                color: Get.theme.colorScheme.onSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            AppSpacing.verticalSmall,
            Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
      // DateContainerWidget(fd: "Nov 16, 2020", ld: "Dec 16, 2020"),
      AttendanceWidget(),
      // FunctionsWidget(),
      CrmCard(
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        padding: EdgeInsets.all(AppPadding.small),
        child: Column(
          children: [CrmHeadline(title: "Leads Overview"), LeadGraphScreen()],
        ),
      ),
      CrmCard(
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        padding: EdgeInsets.all(AppPadding.small),
        child: Column(
          children: [
            CrmHeadline(title: "Leads Overview"),
            LeadLineGraphScreen(),
          ],
        ),
      ),
      CrmCard(
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        padding: EdgeInsets.all(AppPadding.small),
        child: Column(
          children: [
            CrmHeadline(title: "Leads Overview"),
            const SizedBox(height: 16),

            LeadPieChartScreen(
              lead: [
                LeadModel(
                  leadTitle: "Lead 1",
                  leadStage: "New",
                  leadValue: 5000,
                ),
                LeadModel(
                  leadTitle: "Lead 6",
                  leadStage: "New",
                  leadValue: 5000,
                ),
                LeadModel(
                  leadTitle: "Lead 7",
                  leadStage: "New",
                  leadValue: 5000,
                ),
                LeadModel(
                  leadTitle: "Lead 8",
                  leadStage: "New",
                  leadValue: 5000,
                ),
                LeadModel(
                  leadTitle: "Lead 1",
                  leadStage: "New",
                  leadValue: 5000,
                ),
                LeadModel(
                  leadTitle: "Lead 2",
                  leadStage: "Contacted",
                  leadValue: 7000,
                ),
                LeadModel(
                  leadTitle: "Lead 3",
                  leadStage: "New",
                  leadValue: 3000,
                ),
                LeadModel(
                  leadTitle: "Lead 4",
                  leadStage: "Qualified",
                  leadValue: 10000,
                ),
                LeadModel(
                  leadTitle: "Lead 5",
                  leadStage: "Contacted",
                  leadValue: 4000,
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}

class LeadGraphScreen extends StatelessWidget {
  final List<LeadModel> leads = [
    LeadModel(leadTitle: "Lead 1", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 6", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 7", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 8", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 1", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 2", leadStage: "Contacted", leadValue: 7000),
    LeadModel(leadTitle: "Lead 3", leadStage: "New", leadValue: 3000),
    LeadModel(leadTitle: "Lead 4", leadStage: "Qualified", leadValue: 10000),
    LeadModel(leadTitle: "Lead 5", leadStage: "Contacted", leadValue: 4000),
  ];

  Map<String, int> _groupLeadsByStage() {
    Map<String, int> data = {};
    for (var lead in leads) {
      if (lead.leadStage != null) {
        data[lead.leadStage!] = (data[lead.leadStage!] ?? 0) + 1;
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final leadData = _groupLeadsByStage();
    final stages = leadData.keys.toList();
    final values = leadData.values.toList();

    final maxY = (values.reduce((a, b) => a > b ? a : b) + 1).toDouble();

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 26),
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
                    color: Colors.blue,
                    width: 20,
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
                  maxIncluded: true,
                  minIncluded: true,
                  reservedSize: 10,
                  interval: 1, // Show all integer values
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

class LeadLineGraphScreen extends StatelessWidget {
  final List<LeadModel> leads = [
    LeadModel(leadTitle: "Lead 1", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 6", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 7", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 8", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 1", leadStage: "New", leadValue: 5000),
    LeadModel(leadTitle: "Lead 2", leadStage: "Contacted", leadValue: 7000),
    LeadModel(leadTitle: "Lead 3", leadStage: "New", leadValue: 3000),
    LeadModel(leadTitle: "Lead 4", leadStage: "Qualified", leadValue: 10000),
    LeadModel(leadTitle: "Lead 5", leadStage: "Contacted", leadValue: 4000),
  ];

  // Group leads by stage and count occurrences
  Map<String, int> _groupLeadsByStage() {
    Map<String, int> data = {};
    for (var lead in leads) {
      if (lead.leadStage != null) {
        data[lead.leadStage!] = (data[lead.leadStage!] ?? 0) + 1;
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final stages =
        leads
            .map((lead) => lead.leadStage)
            .where((stage) => stage != null)
            .toSet()
            .toList();

    final values =
        stages.map((stage) {
          return leads
              .where((lead) => lead.leadStage == stage)
              .length
              .toDouble();
        }).toList();

    final maxY =
        (values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 1) + 1;

    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: LineChart(
          LineChartData(
            maxY: maxY.toDouble(),
            minY: 0,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  values.length,
                  (index) => FlSpot(index.toDouble(), values[index]),
                ),
                isCurved: true,
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                ),
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter:
                      (spot, percent, bar, index) => FlDotCirclePainter(
                        radius: 6,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: Colors.blueAccent,
                      ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.3),
                      Colors.blueAccent.withOpacity(0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,

                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final idx = value.round(); // safer than toInt()
                    if (idx >= 0 && idx < stages.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8,
                        ),
                        child: Text(
                          stages[idx]!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),

              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 35,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              horizontalInterval: 1,
              drawVerticalLine: false,
              getDrawingHorizontalLine:
                  (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.4)),
                left: BorderSide(color: Colors.grey.withOpacity(0.4)),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LeadPieChartScreen extends StatefulWidget {
  final List<LeadModel> lead;
  const LeadPieChartScreen({super.key, required this.lead});

  @override
  State<LeadPieChartScreen> createState() => _LeadPieChartScreenState();
}

class _LeadPieChartScreenState extends State<LeadPieChartScreen> {
  int? touchedIndex;

  // final List<LeadModel> leads = [
  //   LeadModel(leadTitle: "Lead 1", leadStage: "New", leadValue: 5000),
  //   LeadModel(leadTitle: "Lead 6", leadStage: "New", leadValue: 5000),
  //   LeadModel(leadTitle: "Lead 7", leadStage: "New", leadValue: 5000),
  //   LeadModel(leadTitle: "Lead 8", leadStage: "New", leadValue: 5000),
  //   LeadModel(leadTitle: "Lead 1", leadStage: "New", leadValue: 5000),
  //   LeadModel(leadTitle: "Lead 2", leadStage: "Contacted", leadValue: 7000),
  //   LeadModel(leadTitle: "Lead 3", leadStage: "New", leadValue: 3000),
  //   LeadModel(leadTitle: "Lead 4", leadStage: "Qualified", leadValue: 10000),
  //   LeadModel(leadTitle: "Lead 5", leadStage: "Contacted", leadValue: 4000),
  // ];

  @override
  Widget build(BuildContext context) {
    // Group lead values by stage
    final Map<String, int> stageTotals = {};
    for (var lead in widget.lead) {
      if (lead.leadStage != null && lead.leadValue != null) {
        stageTotals[lead.leadStage!] =
            (stageTotals[lead.leadStage!] ?? 0) + lead.leadValue!;
      }
    }

    final int totalValue = stageTotals.values.fold(
      0,
      (sum, value) => sum + value,
    );

    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];

    final List<PieChartSectionData> sections = [];
    int colorIndex = 0;
    stageTotals.forEach((stage, value) {
      final percentage = ((value / totalValue) * 100).toStringAsFixed(1);
      sections.add(
        PieChartSectionData(
          color: colors[colorIndex % colors.length],
          value: value.toDouble(),
          title: "$percentage%",
          radius: touchedIndex == colorIndex ? 100 : 80,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      colorIndex++;
    });

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
          SizedBox(height: 20),
          // Legend
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  stageTotals.keys.toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    String stage = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            color: colors[index % colors.length],
                          ),
                          const SizedBox(width: 5),
                          Text(stage),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
