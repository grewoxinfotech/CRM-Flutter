import 'package:get/get.dart';
import '../../../data/network/dashboard/model/dashboard_deal.dart';
import '../../../data/network/dashboard/service/dashboard_deal_service.dart';

class DealAggregationController extends GetxController {
  final DealAggregationService _service = DealAggregationService();

  // Observables
  var isLoading = false.obs;
  var dealAggregationResponse = Rxn<DealAggregationResponse>();

  // Aggregated lists for easy access
  var byStage = <StageAggregation>[].obs;
  var byStatus = <StatusAggregation>[].obs;
  var bySource = <SourceAggregation>[].obs;
  var byCategory = <CategoryAggregation>[].obs;
  var byPipeline = <PipelineAggregation>[].obs;

  // Metadata
  var totalDeals = 0.obs;
  var newestDeal = Rxn<NewestDeal>();

  @override
  void onInit() {
    super.onInit();
    fetchDealAggregations();
  }

  /// Fetch deal aggregations from API
  Future<void> fetchDealAggregations() async {
    try {
      isLoading.value = true;

      final response = await _service.fetchDealAggregations();
      if (response != null) {
        dealAggregationResponse.value = response;

        byStage.value = response.message?.aggregations?.byStage ?? [];
        byStatus.value = response.message?.aggregations?.byStatus ?? [];
        bySource.value = response.message?.aggregations?.bySource ?? [];
        byCategory.value = response.message?.aggregations?.byCategory ?? [];
        byPipeline.value = response.message?.aggregations?.byPipeline ?? [];

        totalDeals.value = response.message?.metadata?.totalDeals ?? 0;
        newestDeal.value = response.message?.metadata?.newestDeal;
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper to get stage name by ID
  String getStageName(String stageId) {
    try {
      return byStage.firstWhere((s) => s.stage == stageId).stageName;
    } catch (e) {
      return '';
    }
  }

  /// Helper to get status count by status name
  int getStatusCount(String status) {
    try {
      return byStatus.firstWhere((s) => s.status == status).dealCount;
    } catch (e) {
      return 0;
    }
  }

  /// Helper to get source name by ID
  String getSourceName(String sourceId) {
    try {
      return bySource.firstWhere((s) => s.source == sourceId).sourceName;
    } catch (e) {
      return '';
    }
  }

  /// Helper to get category name by ID
  String getCategoryName(String categoryId) {
    try {
      return byCategory
          .firstWhere((c) => c.category == categoryId)
          .categoryName;
    } catch (e) {
      return '';
    }
  }

  /// Helper to get pipeline name by ID
  String getPipelineName(String pipelineId) {
    try {
      return byPipeline
          .firstWhere((p) => p.pipeline == pipelineId)
          .pipelineName;
    } catch (e) {
      return '';
    }
  }
}
