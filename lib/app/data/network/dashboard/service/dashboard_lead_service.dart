import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../model/dashboard_lead.dart';

class LeadAggregationService {
  final String baseUrl = UrlRes.leadsAggregation; // Define this in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch lead aggregations
  Future<LeadAggregationResponse?> fetchLeadAggregations() async {
    try {
      final uri = Uri.parse(baseUrl);

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LeadAggregationResponse.fromJson(data);
      } else {
        print("Failed to load lead aggregations: ${response.statusCode}");
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to fetch lead aggregations",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Exception in fetchLeadAggregations: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching lead aggregations",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Get single lead aggregation by stage ID (optional example)
  Future<StageAggregation?> getStageById(String stageId) async {
    final aggregationResponse = await fetchLeadAggregations();
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

  /// Additional functions can be added if the API supports create/update/delete
  /// For example, createLead, updateLead, deleteLead etc.
}
