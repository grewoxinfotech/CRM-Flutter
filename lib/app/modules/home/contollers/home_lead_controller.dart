import 'package:get/get.dart';
import '../../../data/network/dashboard/model/dashboard_lead.dart';
import '../../../data/network/dashboard/service/dashboard_lead_service.dart';

class LeadAggregationController extends GetxController {
  final LeadAggregationService _service = LeadAggregationService();

  // Observables
  var isLoading = false.obs;
  var leadAggregationResponse = Rxn<LeadAggregationResponse>();

  // Aggregated lists for easy access
  var byStage = <StageAggregation>[].obs;
  var byStatus = <StatusAggregation>[].obs;
  var bySource = <SourceAggregation>[].obs;
  var byInterestLevel = <InterestLevelAggregation>[].obs;

  // Metadata
  var totalLeads = 0.obs;
  var newestLead = Rxn<NewestLead>();

  @override
  void onInit() {
    super.onInit();
    fetchLeadAggregations();
  }

  /// Fetch lead aggregations from API
  Future<void> fetchLeadAggregations() async {
    try {
      isLoading.value = true;

      final response = await _service.fetchLeadAggregations();
      if (response != null) {
        leadAggregationResponse.value = response;

        byStage.value = response.message?.aggregations?.byStage ?? [];
        byStatus.value = response.message?.aggregations?.byStatus ?? [];
        bySource.value = response.message?.aggregations?.bySource ?? [];
        byInterestLevel.value =
            response.message?.aggregations?.byInterestLevel ?? [];

        totalLeads.value = response.message?.metadata?.totalLeads ?? 0;
        newestLead.value = response.message?.metadata?.newestLead;
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

  /// Helper to get status name by ID
  String getStatusName(String statusId) {
    try {
      return byStatus.firstWhere((s) => s.status == statusId).statusName;
    } catch (e) {
      return 'N/A';
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

  /// Helper to get interest level count
  int getInterestLevelCount(String interestLevel) {
    try {
      return byInterestLevel
          .firstWhere((i) => i.interestLevel == interestLevel)
          .leadCount;
    } catch (e) {
      return 0;
    }
  }
}
