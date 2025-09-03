import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../model/dashboard_deal.dart';

class DealAggregationService {
  final String baseUrl = UrlRes.dealsAggregation; // Define this in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch deal aggregations
  Future<DealAggregationResponse?> fetchDealAggregations() async {
    try {
      final uri = Uri.parse(baseUrl);

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DealAggregationResponse.fromJson(data);
      } else {
        print("Failed to load deal aggregations: ${response.statusCode}");
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to fetch deal aggregations",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Exception in fetchDealAggregations: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching deal aggregations",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Get single stage aggregation by stage ID
  Future<StageAggregation?> getStageById(String stageId) async {
    final aggregationResponse = await fetchDealAggregations();
    if (aggregationResponse?.message?.aggregations?.byStage != null) {
      try {
        return aggregationResponse!.message!.aggregations!.byStage!.firstWhere(
          (stage) => stage.stage == stageId,
        );
      } catch (e) {
        print("Stage with ID $stageId not found");
      }
    }
    return null;
  }

  /// Get single status aggregation by status
  Future<StatusAggregation?> getStatusByName(String statusName) async {
    final aggregationResponse = await fetchDealAggregations();
    if (aggregationResponse?.message?.aggregations?.byStatus != null) {
      try {
        return aggregationResponse!.message!.aggregations!.byStatus!.firstWhere(
          (status) => status.status == statusName,
        );
      } catch (e) {
        print("Status $statusName not found");
      }
    }
    return null;
  }

  /// Additional functions can be added if the API supports create/update/delete
  /// For example, createDeal, updateDeal, deleteDeal etc.
}
