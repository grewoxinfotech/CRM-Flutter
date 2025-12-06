
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../care/constants/size_manager.dart';
import '../../../care/widget/graphs/aggregationPieChart.dart';
import '../../../data/network/dashboard/model/dashboard_deal.dart';
import '../../../widgets/common/display/crm_card.dart';
import '../../../widgets/common/display/crm_headline.dart';
import '../contollers/home_deal_controller.dart';


class DealsOverviewCard extends StatelessWidget {
  DealsOverviewCard({super.key});

  final DealAggregationController controller =
  Get.put(DealAggregationController());

  final Map<String, String> filters = {
    "byStage": "Stage",
    "byStatus": "Status",
    "bySource": "Source",
    "byCategory": "Category",
    "byPipeline": "Pipeline",
  };

  final GlobalKey _filterButtonKey = GlobalKey();

  final RxString currentFilter = "byStage".obs;

  void _showFilterMenu(BuildContext context) async {
    final renderBox =
    _filterButtonKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height + 8,
        position.dx + size.width,
        position.dy,
      ),
      items: filters.entries
          .map(
            (entry) => PopupMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        ),
      )
          .toList(),
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    if (selected != null && selected != currentFilter.value) {
      currentFilter.value = selected;
    }
  }

  /// Get aggregation data based on selected filter
  Map<String, int> _getAggregationData() {
    switch (currentFilter.value) {
      case "byStage":
        return {for (var s in controller.byStage) s.stageName: s.dealCount};
      case "byStatus":
        return {for (var s in controller.byStatus) s.status: s.dealCount};
      case "bySource":
        return {for (var s in controller.bySource) s.sourceName: s.dealCount};
      case "byCategory":
        return {for (var c in controller.byCategory) c.categoryName: c.dealCount};
      case "byPipeline":
        return {for (var p in controller.byPipeline) p.pipelineName: p.dealCount};
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => CrmCard(
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        padding: EdgeInsets.all(AppPadding.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CrmHeadline(title: "Deals Overview"),
                InkWell(
                  key: _filterButtonKey,
                  borderRadius: BorderRadius.circular(24),
                  onTap: () => _showFilterMenu(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Text(
                          filters[currentFilter.value] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : AggregationPieChart(
              aggregationData: _getAggregationData(),
              colors: [Colors.red, Colors.blue, Colors.green],
            ),
          ],
        ),
      ),
    );
  }
}
