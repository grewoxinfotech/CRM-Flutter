import 'package:flutter/material.dart';

import '../../../care/constants/size_manager.dart';
import '../../../care/widget/graphs/aggregationPieChart.dart';
import '../../../data/network/dashboard/model/dashboard_deal.dart';
import '../../../widgets/common/display/crm_card.dart';
import '../../../widgets/common/display/crm_headline.dart';

class DealsOverviewCard extends StatefulWidget {
  final DealAggregationResponse? aggregationResponse; // pass data here

  const DealsOverviewCard({super.key, this.aggregationResponse});

  @override
  State<DealsOverviewCard> createState() => _DealsOverviewCardState();
}

class _DealsOverviewCardState extends State<DealsOverviewCard> {
  Map<String, int> aggregationData = {};
  String currentFilter = "byStage";

  final Map<String, String> filters = {
    "byStage": "Stage",
    "byStatus": "Status",
    "bySource": "Source",
    "byCategory": "Category",
    "byPipeline": "Pipeline",
  };

  final GlobalKey _filterButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _updateAggregationData();
  }

  void _updateAggregationData() {
    Map<String, int> newData = {};
    final agg = widget.aggregationResponse?.message?.aggregations;

    switch (currentFilter) {
      case "byStage":
        for (var stage in agg?.byStage ?? []) {
          newData[stage.stageName] = stage.dealCount;
        }
        break;
      case "byStatus":
        for (var status in agg?.byStatus ?? []) {
          newData[status.status] = status.dealCount;
        }
        break;
      case "bySource":
        for (var source in agg?.bySource ?? []) {
          newData[source.sourceName] = source.dealCount;
        }
        break;
      case "byCategory":
        for (var category in agg?.byCategory ?? []) {
          newData[category.categoryName] = category.dealCount;
        }
        break;
      case "byPipeline":
        for (var pipeline in agg?.byPipeline ?? []) {
          newData[pipeline.pipelineName] = pipeline.dealCount;
        }
        break;
    }

    setState(() {
      aggregationData = newData;
    });
  }

  void _showFilterMenu() async {
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
      items:
          filters.entries
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

    if (selected != null && selected != currentFilter) {
      setState(() {
        currentFilter = selected;
      });
      _updateAggregationData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CrmCard(
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
                onTap: _showFilterMenu,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Text(
                        filters[currentFilter] ?? '',
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
          AggregationPieChart(aggregationData: aggregationData),
        ],
      ),
    );
  }
}

class DealDummyData {
  static DealAggregationResponse dummyDealAggregationResponse =
      DealAggregationResponse(
        success: true,
        message: Message(
          aggregations: Aggregations(
            byStage: [
              StageAggregation(
                stage: "stage1",
                stageName: "New Campaign",
                dealCount: 3,
              ),
              StageAggregation(
                stage: "stage2",
                stageName: "Negotiation",
                dealCount: 2,
              ),
            ],
            byStatus: [
              StatusAggregation(status: "pending", dealCount: 4),
              StatusAggregation(status: "won", dealCount: 1),
            ],
            bySource: [
              SourceAggregation(
                source: "source1",
                sourceName: "Website",
                dealCount: 2,
              ),
              SourceAggregation(
                source: "source2",
                sourceName: "Referral",
                dealCount: 3,
              ),
            ],
            byCategory: [
              CategoryAggregation(
                category: "cat1",
                categoryName: "Marketing",
                dealCount: 2,
              ),
              CategoryAggregation(
                category: "cat2",
                categoryName: "Sales",
                dealCount: 3,
              ),
            ],
            byPipeline: [
              PipelineAggregation(
                pipeline: "pipe1",
                pipelineName: "Pipeline A",
                dealCount: 3,
              ),
              PipelineAggregation(
                pipeline: "pipe2",
                pipelineName: "Pipeline B",
                dealCount: 2,
              ),
            ],
          ),
          metadata: Metadata(
            totalDeals: 5,
            newestDeal: NewestDeal(
              id: "deal123",
              dealTitle: "Big Deal",
              createdAt: "2025-09-03T12:00:00.000Z",
            ),
          ),
        ),
        data: null,
      );
}
